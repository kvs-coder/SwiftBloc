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

    func copyWith(count: Int?) -> CounterState {
        CounterState(count: count ?? self.count)
    }
}

class CounterBloc: Bloc<CounterEvent, CounterState> {
    init() {
        super.init(initialState: CounterState(count: 0))
    }

    override func mapEventToState(event: CounterEvent) -> CounterState {
        switch event {
        case .increment:
            return state.copyWith(count: state.count + 1)
        case .decrement:
            return state.copyWith(count: state.count - 1)
        }
    }
}
