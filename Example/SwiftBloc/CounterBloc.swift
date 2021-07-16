//
//  CounterBloc.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 28.02.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftBloc
import SwiftUI

enum CounterEvent {
    case increment
    case decrement
}

struct CounterState: Equatable {
    let count: Int
    let shouldShowAlert: Bool

    func copyWith(count: Int?, shouldShowAlert: Bool?) -> CounterState {
        CounterState(count: count ?? self.count, shouldShowAlert: shouldShowAlert ?? self.shouldShowAlert)
    }
}

class CounterBloc: Bloc<CounterEvent, CounterState> {
    var shouldShowAlertBinding: Binding<Bool> {
        Binding.constant(state.shouldShowAlert)
    }

    init() {
        super.init(initialState: CounterState(count: 0, shouldShowAlert: false))
    }

    override func mapEventToState(event: CounterEvent) -> CounterState {
        switch event {
        case .increment:
            return state.copyWith(count: state.count + 1, shouldShowAlert: true)
        case .decrement:
            return state.copyWith(count: state.count - 1, shouldShowAlert: false)
        }
    }
}
