import XCTest
import Combine
@testable import SwiftBloc

final class SwiftBlocTests: XCTestCase {
    func testExample() {
        XCTAssert(true)
    }
    func testCounterBlocInitial() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (_) in
            // DO NOTHING
        }, expect: {
            [
                MockCounterState(count: 0)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterBlocIncrement() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (bloc) in
            bloc.add(event: .increment)
            bloc.add(event: .increment)
        }, expect: {
            [
                MockCounterState(count: 0),
                MockCounterState(count: 1),
                MockCounterState(count: 2)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterBlocDecrement() {
        BlocTest.execute(build: {
            MockCounterBloc()
        }, act: { (bloc) in
            bloc.add(event: .decrement)
            bloc.add(event: .decrement)
        }, wait: 3.0, expect: {
            [
                MockCounterState(count: 0),
                MockCounterState(count: -1),
                MockCounterState(count: -2)
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterCubitInitial() {
        BlocTest.execute(build: {
            MockCounterCubit()
        }, act: { (_) in
            // DO NOTHING
        }, expect: {
            [
                0
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterCubitIncrement() {
        BlocTest.execute(build: {
            MockCounterCubit()
        }, act: { (cubit) in
            cubit.increment()
            cubit.increment()
        }, expect: {
            [
                0,
                1,
                2
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }
    func testCounterCubitDecrement() {
        BlocTest.execute(build: {
            MockCounterCubit()
        }, act: { (cubit) in
            cubit.decrement()
            cubit.decrement()
        }, expect: {
            [
                0,
                -1,
                -2
            ]
        }, verify: { areEqual, message in
            XCTAssert(areEqual, message)
        })
    }

    static var allTests = [
        ("testCounterBlocInitial", testCounterBlocInitial),
        ("testCounterBlocIncrement", testCounterBlocIncrement),
        ("testCounterBlocDecrement", testCounterBlocDecrement),
        ("testCounterCubitInitial", testCounterCubitInitial),
        ("testCounterCubitIncrement", testCounterCubitIncrement),
        ("testCounterCubitDecrement", testCounterCubitDecrement)
    ]
}
