//
//  Base.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Combine

/**
 A state managing base class.
 */
open class Base<State>: ObservableObject where State: Equatable {
    /**
     Whenever a state will be changed, the instance of the **Cubit** wrapped in **ObservedObject** in your **View** structure will receive
     a new value of state. Based on this you can set the strict dependency of how to build your views.
     */
    @Published internal(set) public var state: State
    /**
     Additional variable to make sure that previously the cubit was not emitting any new states
     */
    var emitted = false
    /**
     Will return a shared instance of **BlocObserver** which will notify about changes and transitions of states
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
        observer.onCreate(base: self)
    }
    /**
     Deinitializer which will trigger observer callback **onClose**
     */
    deinit {
        observer.onClose(base: self)
    }
}
