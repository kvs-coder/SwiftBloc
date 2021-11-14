//
//  Cubit.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Combine

/**
 A state managing class not dependent on incoming events.
 */
open class Cubit<State>: Base<State> where State: Equatable {
    /**
     Emits a new state.
     - parameter state: new state.
     */
    public func emit(state: State) {
        if state == self.state && emitted {
            observer.onError(base: self, error: CubitError.stateNotChanged)
            return
        }
        let change = Change(currentState: self.state, nextState: state)
        observer.onChange(base: self, change: change)
        self.state = state
        emitted = true
    }
}
