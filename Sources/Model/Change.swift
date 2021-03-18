//
//  Change.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

/**
 Change class for tracking state changes
*/
public class Change<State> {
    public let currentState: State
    public let nextState: State

    var description: String {
        "Change currentState: \(currentState) to nextState: \(nextState)"
    }

    init(currentState: State, nextState: State) {
        self.currentState = currentState
        self.nextState = nextState
    }
}
// MARK: - Equatable
extension Change: Equatable where State: Equatable {
    public static func == (lhs: Change<State>, rhs: Change<State>) -> Bool {
        lhs.currentState == rhs.currentState && lhs.nextState == rhs.nextState
    }
}
