//
//  BlocObserver.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Foundation

/**
 An observer to observe emitted states or added events.
 You may create your own singleton observer class and set a new value for a **shared** property
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
    open func onCreate<State>(base: Base<State>) {
        logInfo(base)
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
     Called when state changes in **Base** instance.
     - parameter base: base.
     - parameter change: a change to a new state.
     */
    open func onChange<State>(base: Base<State>, change: Change<State>) {
        logInfo("\(base), \(change)")
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
     Called if an error occurs in **Cubit** or **Bloc** instance.
     - parameter base: cubit.
     - parameter error: a reported error.
     */
    open func onError<State>(base: Base<State>, error: Error) {
        logError("\(base), \(error)")
    }
    /**
     Called when **BlocBase** or **Bloc** instance is destroyed.
     - parameter base: base.
     */
    open func onClose<State>(base: Base<State>) {
        logInfo(base)
    }
}
