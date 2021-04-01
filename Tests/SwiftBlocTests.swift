import XCTest
import Combine
@testable import SwiftBloc

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


final class SwiftBlocTests: XCTestCase {
    func testExample() {
        XCTAssert(true)
    }
//    func testCounterBlocInitial() {
//        BlocTest.execute(description: "CounterBloc", build: {
//            MockCounterBloc()
//        }, act: { (_) in
//            // DO NOTHING
//        }, expect: {
//            [
//                MockCounterState(count: 0)
//            ]
//        })
//    }
//    func testCounterBlocIncrement() {
//        BlocTest.execute(description: "CounterBloc", build: {
//            MockCounterBloc()
//        }, act: { (bloc) in
//            bloc.add(event: .increment)
//            bloc.add(event: .increment)
//        }, expect: {
//            [
//                MockCounterState(count: 0),
//                MockCounterState(count: 1),
//                MockCounterState(count: 2)
//            ]
//        })
//    }
//    func testCounterBlocDecrement() {
//        BlocTest.execute(description: "CounterBloc", build: {
//            MockCounterBloc()
//        }, act: { (bloc) in
//            bloc.add(event: .decrement)
//            bloc.add(event: .decrement)
//        }, wait: 3.0, expect: {
//            [
//                MockCounterState(count: 0),
//                MockCounterState(count: -1),
//                MockCounterState(count: -2)
//            ]
//        })
//    }
//    func testCounterCubitInitial() {
//        BlocTest.execute(description: "CounterCubit", build: {
//            MockCounterCubit()
//        }, act: { (_) in
//            // DO NOTHING
//        }, expect: {
//            [
//                0
//            ]
//        })
//    }
//    func testCounterCubitIncrement() {
//        BlocTest.execute(description: "CounterBloc", build: {
//            MockCounterCubit()
//        }, act: { (cubit) in
//            cubit.increment()
//            cubit.increment()
//        }, expect: {
//            [
//                0,
//                1,
//                2
//            ]
//        })
//    }
//    func testCounterCubitDecrement() {
//        BlocTest.execute(description: "CounterBloc", build: {
//            MockCounterCubit()
//        }, act: { (cubit) in
//            cubit.decrement()
//            cubit.decrement()
//        }, expect: {
//            [
//                0,
//                -1,
//                -2
//            ]
//        })
//    }
//
//    static var allTests = [
//        ("testCounterBlocInitial", testCounterBlocInitial),
//        ("testCounterBlocIncrement", testCounterBlocIncrement),
//        ("testCounterBlocDecrement", testCounterBlocDecrement),
//        ("testCounterCubitInitial", testCounterCubitInitial),
//        ("testCounterCubitIncrement", testCounterCubitIncrement),
//        ("testCounterCubitDecrement", testCounterCubitDecrement)
//    ]
}
