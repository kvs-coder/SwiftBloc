//
//  BlocObserver.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

open class BlocObserver {
    public init() {
        logInfo("BlocObserver init")
    }

    deinit {
        logInfo("BlocObserver deinit")
    }

    open func onCreate<State>(cubit: Cubit<State>) {
        logInfo(cubit)
    }
    open func onEvent<Event, State>(bloc: Bloc<Event, State>, event: Event) {
        logInfo("\(bloc), \(event)")
    }
    open func onChange<State>(cubit: Cubit<State>, change: Change<State>) {
        logInfo("\(cubit), \(change)")
    }
    open func onTransition<Event, State>(bloc: Bloc<Event, State>, transition: Transition<Event, State>) {
        logInfo("\(bloc), \(transition)")
    }
    open func onError<State>(cubit: Cubit<State>, error: Error) {
        logError("\(cubit), \(error)")
    }
    open func onClose<State>(cubit: Cubit<State>) {
        logInfo(cubit)
    }
}
