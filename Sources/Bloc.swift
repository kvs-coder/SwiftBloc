//
//  Bloc.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Combine

/**
 A state managing class with lower level of abstraction and unlike **Cubit** it depends on incoming events.
 */
open class Bloc<Event, State>: Base<State> where State: Equatable, Event: Equatable {
    /**
     Whenever a new event happens, the instance of the **Bloc** wrapped in **ObservedObject**  in your **View** structure will receive
     a new value of event..
     */
    @Published internal(set) public var event: Event?
    /**
     A collector for **AnyCancellable**
     */
    private var cancellables = Set<AnyCancellable>()
    /**
     Bloc constructor
     - parameter initialState: initial state.
     */
    public init(initialState: State) {
        super.init(state: initialState)
        bindEventsToStates()
    }
    /**
     Deinitializer which will trigger observer callback **onClose** and remove all cancellables.
     */
    deinit {
        cancellables.forEach { $0.cancel() }
        observer.onClose(base: self)
    }
    /**
     Adds a new event.
     - parameter event: new event.
     */
    public func add(event: Event) {
        observer.onEvent(bloc: self, event: event)
        self.event = event
    }
    /**
     The mapping function which is responsible for creating states out of event.
     The idea is to listen for the incoming event and based on that create an appropriate new state of the view
     - parameter event: incoming event.
     - returns: new state instance
     - warning: The function should be overridden in a child class
     
     # Notes: #
     1. If not overridden, will fail with **preconditionFailure**
     */
    open func mapEventToState(event: Event) -> State {
        preconditionFailure("This method must be overridden")
    }
    /**
     Binds event to state. Function **mapEventToState** is the core of the transition creation
     */
    private func bindEventsToStates() {
        $event
            .compactMap({ [unowned self] (event) -> Transition<Event, State>? in
                guard let event = event else {
                    self.observer.onError(base: self, error: BlocError.noEvent)
                    return nil
                }
                let nextState = self.mapEventToState(event: event)
                return Transition(
                    currentState: self.state,
                    event: event,
                    nextState: nextState
                )
            })
            .map({ [unowned self] (transition) -> State in
                if transition.nextState == self.state && self.emitted {
                    self.observer.onError(base: self, error: CubitError.stateNotChanged)
                    return self.state
                }
                self.observer.onTransition(bloc: self, transition: transition)
                self.emitted = true
                return transition.nextState
            })
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
}
