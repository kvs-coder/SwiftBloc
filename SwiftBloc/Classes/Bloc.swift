//
//  Bloc.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Combine

open class Bloc<Event, State>: Cubit<State> where State: Equatable, Event: Equatable {
    @Published internal(set) public var event: Event?
    
    private var cancellables = Set<AnyCancellable>()

    public init(intialState: State) {
        super.init(state: intialState)
        bindEventsToStates()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    public func add(event: Event) {
        observer?.onEvent(bloc: self, event: event)
        self.event = event
    }
    
    open func onEvent(event: Event) {
        observer?.onEvent(bloc: self, event: event)
    }
    
    open func onTransition(transition: Transition<Event, State>) {
        observer?.onTransition(bloc: self, transition: transition)
    }
    
    open func mapEventToState(event: Event) -> State {
        preconditionFailure("This method must be overridden")
    }
    
    private func bindEventsToStates() {
        $event
            .compactMap ({ [unowned self] (event) -> Transition<Event, State>? in
                guard let event = event else {
                    return nil
                }
                let nextState = self.mapEventToState(event: event)
                return Transition(
                    currentState: self.state,
                    event: event,
                    nextState: nextState
                )
            })
            .map ({ [unowned self] (transition) -> State in
                if transition.nextState == self.state && self.emitted {
                    return self.state
                }
                self.onTransition(transition: transition)
                self.emitted = true
                return transition.nextState
            })
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
}
