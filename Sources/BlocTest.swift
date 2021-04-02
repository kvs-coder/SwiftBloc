//
//  BlocTest.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.04.21.
//

import Foundation
import Combine

//final public class BlocTest<S: Equatable, B: Base<S>> {
//    public static func execute(
//        build: () -> B,
//        act: ((B) -> Void)?,
//        wait: TimeInterval? = 0,
//        expect: (() -> Any)?,
//        verify: ((Bool, String) -> Void)
//    ) {
//        var areEqual = false
//        var states = [S]()
//        let bloc = build()
//        let scheduler = ImmediateScheduler.shared
//        let cancellable = bloc.$state
//            .subscribe(on: scheduler)
//            .delay(for: .seconds(wait ?? 0), scheduler: scheduler)
//            .sink(receiveValue: { value in
//                states.append(value)
//            })
//        act?(bloc)
//        if expect != nil {
//            let expected = expect!()
//            areEqual = "\(states)" == "\(expected)"
//            let message = "State received: \(states). \nStates expected: \(expected)"
//            verify(areEqual, message)
//        }
//        cancellable.cancel()
//    }
//}
