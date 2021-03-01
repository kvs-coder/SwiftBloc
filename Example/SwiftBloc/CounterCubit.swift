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
    }

    func increment() {
        emit(state: state + 1)
    }
    func decrement() {
         emit(state: state - 1)
     }
}
