//
//  Cubit.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Combine

open class Cubit<State>: ObservableObject where State: Equatable {
    @Published public var state: State

    var emitted = false

    public var observer: BlocObserver?

    public init(state: State) {
        self.state = state
        observer?.onCreate(cubit: self)
    }

    public func emit(state: State) {
        if state == self.state && emitted {
            return
        }
        let change = Change(currentState: self.state, nextState: state)
        observer?.onChange(cubit: self, change: change)
        self.state = state
        emitted = true
    }

    open func onError(error: Error) {
        observer?.onError(cubit: self, error: error)
    }

    open func onChange(change: Change<State>) {
        observer?.onChange(cubit: self, change: change)
    }

    public func close() {
        observer?.onClose(cubit: self)
    }
}
