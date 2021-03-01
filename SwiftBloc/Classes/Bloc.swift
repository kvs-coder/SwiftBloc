//
//  Bloc.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Combine

open class Bloc<Event, State>: Cubit<State> where State: Equatable, Event: Equatable {
    private let subject = PassthroughSubject<Event, Never>()
    
    public init(intialState: State) {
        super.init(state: intialState)
        bindEventsToStates()
    }
    
    public func add(event: Event) {
        observer?.onEvent(bloc: self, event: event)
        subject.send(event)
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
//        subscriber = subject
//            .map ({ [unowned self] (event) -> Transition<Event, State> in
//                let nextState = self.mapEventToState(event: event)
//                return Transition(
//                    currentState: self.state,
//                    event: event,
//                    nextState: nextState
//                )
//            })
//            .sink(receiveValue: { [unowned self] (transition) in
//                if transition.nextState == self.state && self.emitted {
//                    return
//                }
//                self.onTransition(transition: transition)
//                self.emit(state: transition.nextState)
//                self.emitted = true
//            })
    }
}
