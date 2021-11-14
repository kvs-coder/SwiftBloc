//
//  MockCounterBloc.swift
//  SwiftBloc_Tests
//
//  Created by Kachalov, Victor on 01.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftBloc

enum MockCounterEvent {
    case increment
    case decrement
}

struct MockCounterState: Equatable {
    let count: Int

    func copyWith(count: Int?) -> MockCounterState {
        MockCounterState(count: count ?? self.count)
    }
}

class MockCounterBloc: Bloc<MockCounterEvent, MockCounterState> {
    init() {
        super.init(initialState: MockCounterState(count: 0))
    }

    override func mapEventToState(event: MockCounterEvent) -> MockCounterState {
        switch event {
        case .increment:
            return state.copyWith(count: state.count + 1)
        case .decrement:
            return state.copyWith(count: state.count - 1)
        }
    }
}

class MockCounterCubit: Cubit<Int> {
    init() {
        super.init(state: 0)
    }

    func increment() {
        emit(state: state + 1)
    }
    func decrement() {
        emit(state: state - 1)
    }
}
