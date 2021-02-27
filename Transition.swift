//
//  Transition.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

class Transition<Event, State>: Change<State> {
    let event: Event
    
    init(
        currentState: State,
        event: Event,
        nextState: State
    ) {
        self.event = event
        super.init(currentState: currentState, nextState: nextState)
    }
}

extension Transition where State: Equatable, Event: Equatable {
    static func == (lhs: Transition<Event, State>, rhs: Transition<Event, State>) -> Bool {
        lhs.currentState == rhs.currentState && lhs.nextState == rhs.nextState && lhs.event == rhs.event
    }
}
