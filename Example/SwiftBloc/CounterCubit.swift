//
//  CounterCubit.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 27.02.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftBloc

class CounterCubit: Cubit<Int> {
    init() {
        super.init(state: 0)
        listen(onCompletion: { (completed) in
            print("Completed: \(completed)")
        }, onValue: { (newValue) in
            print("new value: \(newValue)")
        })
    }

    func increment() {
        emit(state: state + 1)
    }
}
