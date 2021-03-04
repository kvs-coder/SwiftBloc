//
//  Cubit.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Combine

/**
 A state managing class with higher level of abstraction not depending on incoming events.
 */
open class Cubit<State>: ObservableObject where State: Equatable {
    /**
     Whenever a state will be changed, the instance of the **Cubit** wrapped in **ObservedObject** in your **View** structure will recieve
     a new value of state. Based on this you can set the strict dependency of how to build your views.
     */
    @Published internal(set) public var state: State
    /**
     Additional variable to make sure that previosly the cubit was not emmiting any new states
     */
    var emitted = false
    /**
     Will return a shared instace of **BlocObserver** which will notify about changes and transitions of states
     You may create a custom observer of **BlocObserver**
     */
    var observer: BlocObserver {
        BlocObserver.shared
    }
    /**
     Cubit constructor
     - parameter state: initial state.
     */
    public init(state: State) {
        self.state = state
        observer.onCreate(cubit: self)
    }
    /**
     Deinitializer which will trigger observer callback **onClose**
     */
    deinit {
        observer.onClose(cubit: self)
    }
    /**
     Emits a new state.
     - parameter state: new state.
     */
    public func emit(state: State) {
        if state == self.state && emitted {
            observer.onError(cubit: self, error: CubitError.stateNotChanged)
            return
        }
        let change = Change(currentState: self.state, nextState: state)
        observer.onChange(cubit: self, change: change)
        self.state = state
        emitted = true
    }
}
