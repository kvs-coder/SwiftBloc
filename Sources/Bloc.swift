//
//  Bloc.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

//TODO:
// blocTest
import Combine

/**
 A state managing class with lower level of abstraction and unlike **Cubit** it depends on incoming events.
 */
open class Bloc<Event, State>: BlocBase<State> where State: Equatable, Event: Equatable {
    /**
     Whenever a new event happens, the instance of the **Bloc** wrapped in **ObservedObject**  in your **View** structure will recieve
     a new value of event..
     */
    @Published internal(set) public var event: Event?
    /**
     A collector for **AnyCancellable**
     */
    private var cancellables = Set<AnyCancellable>()
    /**
     Bloc constructor
     - parameter intialState: initial state.
     */
    public init(intialState: State) {
        super.init(state: intialState)
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
     The mapping function which is responsable for creating states out of event.
     The idea is to listen for the incoming event and based on that create an appropriate new state of the view
     - parameter event: incoming event.
     - returns: new state instance
     - warning: The function should be overriden in a child class
     
     # Notes: #
     1. If not overriden, will fail with **preconditionFailure**
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
