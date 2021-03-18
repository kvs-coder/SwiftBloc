//
//  Transition.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

/**
 A transition which tracks states based on incoming events
*/
public class Transition<Event, State>: Change<State> {
    public let event: Event

    override var description: String {
        "Event: \(event) transition from currentState: \(currentState) to nextState: \(nextState)"
    }

    init(
        currentState: State,
        event: Event,
        nextState: State
    ) {
        self.event = event
        super.init(currentState: currentState, nextState: nextState)
    }
}
// MARK: - Equatable
extension Transition where State: Equatable, Event: Equatable {
    public static func == (lhs: Transition<Event, State>, rhs: Transition<Event, State>) -> Bool {
        lhs.currentState == rhs.currentState && lhs.nextState == rhs.nextState && lhs.event == rhs.event
    }
}
