//
//  Change.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

public class Change<State> {
    let currentState: State
    
    let nextState: State
    
    var description: String {
        return "Change currentState: \(currentState), nextState: \(nextState) }"
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
