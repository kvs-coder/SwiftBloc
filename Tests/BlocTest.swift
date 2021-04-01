//
//  File.swift
//  
//
//  Created by Kachalov, Victor on 01.04.21.
//

//import Foundation
//import SwiftBloc
//import Combine
//import XCTest
//
//final public class BlocTest<S: Equatable, B: Base<S>> {
//    public static func execute(
//        description: String,
//        build: () -> B,
//        act: ((B) -> Void)?,
//        wait: TimeInterval? = 0,
//        expect: (() -> Any)?,
//        verify: ((B) -> Void)? = nil
//    ) {
//        print("Running test: \(description)")
//        var areEqual = false
//        var states = [S]()
//        let bloc = build()
//        let scheduler = ImmediateScheduler.shared
//        let cancellable = bloc.$state
//            .subscribe(on: scheduler)
//            .delay(for: .seconds(wait ?? 0), scheduler: scheduler)
//            .sink(receiveValue: { value in
//                print("New state added: \(value)")
//                states.append(value)
//            } )
//        act?(bloc)
//        if expect != nil {
//            let expected = expect!()
//            areEqual = "\(states)" == "\(expected)"
//            let message = "State received: \(states). \nStates expected: \(expected)"
//            XCTAssert(areEqual, message)
//        }
//        cancellable.cancel()
//        verify?(bloc)
//    }
//}
