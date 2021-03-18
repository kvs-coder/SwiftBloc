//
//  BlocObserver.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

/**
 An observer to observe emitted states or added events.
 You may creater your own singletone observer class and set a new value for a **shared** property
 */
open class BlocObserver {
    /**
     As a shared instance is used in **Cubit** and **Bloc** to make tracking of event/state changes via callbacks
     */
    public static var shared = BlocObserver()
    /**
     BlocObserver constructor
     - parameter intialState: initial state.
     */
    public init() {
        logInfo("BlocObserver init")
    }

    deinit {
        logInfo("BlocObserver deinit")
    }

    /**
     Called when **Bloc** or **Cubit** instance is created.
     - parameter cubit: cubit or bloc.
     */
    open func onCreate<State>(cubit: Cubit<State>) {
        logInfo(cubit)
    }
    /**
     Called when a new event is added to **Bloc** instance.
     - parameter bloc: bloc.
     - parameter event: a new event.
     */
    open func onEvent<Event, State>(bloc: Bloc<Event, State>, event: Event) {
        logInfo("\(bloc), \(event)")
    }
    /**
     Called when state changes in **Cubit** instance.
     - parameter bloc: bloc.
     - parameter change: a change to a new state.
     */
    open func onChange<State>(cubit: Cubit<State>, change: Change<State>) {
        logInfo("\(cubit), \(change)")
    }
    /**
     Called when state based on the event changes in **Bloc** instance.
     - parameter bloc: bloc.
     - parameter transition: a change to a new state.
     */
    open func onTransition<Event, State>(bloc: Bloc<Event, State>, transition: Transition<Event, State>) {
        logInfo("\(bloc), \(transition)")
    }
    /**
     Called when error is occured in **Cubit** or **Bloc** instance.
     - parameter cubit: cubit.
     - parameter error: a reported error.
     */
    open func onError<State>(cubit: Cubit<State>, error: Error) {
        logError("\(cubit), \(error)")
    }
    /**
     Called when **Cubit** or **Bloc** instance is destroyed.
     - parameter cubit: cubit.
     */
    open func onClose<State>(cubit: Cubit<State>) {
        logInfo(cubit)
    }
}
