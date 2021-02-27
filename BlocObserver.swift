//
//  BlocObserver.swift
//  Pods-SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//

import Foundation

class BlocObserver {

    func onCreate<State>(cubit: Cubit<State>) {}

    func onEvent(bloc: Bloc, event: Any) {}

    func onChange<State>(cubit: Cubit<State>, change: Change<State>) {}

    func onTransition<Event, State>(bloc: Bloc, transition: Transition<Event, State>) {}
    
    func onError<State>(cubit: Cubit<State>, error: Any) {}

    func onClose<State>(cubit: Cubit<State>) {}
}
