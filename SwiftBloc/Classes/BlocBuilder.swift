//
//  BlocBuilder.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 28.02.21.
//

import SwiftUI

public typealias BlocViewBuilder<S: Equatable, Content: View> = (_ state: S) -> Content
public typealias BlocBuilderCondition<S: Equatable> = (_ previous: S, _ current: S) -> Bool

public struct BlocBuilder<C: Cubit<S>, S: Equatable, Content: View>: BlocBuilderBase  {
    @ObservedObject internal var cubit: C

    private var state: S {
        return cubit.state
    }

    let buildWhen: BlocBuilderCondition<S>
    let builder: BlocViewBuilder<S, Content>
    
    public var body: some View {
        return build(state: state)
    }

    public init(
        builder: @escaping BlocViewBuilder<S, Content>,
        cubit: C,
        buildWhen: @escaping BlocBuilderCondition<S>
    ) {
        self.builder = builder
        self.buildWhen = buildWhen
        self.cubit = cubit
    }

    func build(state: S) -> Content {
        return builder(state)
    }
}

protocol BlocBuilderBase: View {
    associatedtype S where S: Equatable
    associatedtype C where C: Cubit<S>
    associatedtype Content where Content: View
    
    var cubit: C { get }
    var buildWhen: BlocBuilderCondition<S> { get }
    
    func build(state: S) -> Content
}



//enum CounterEvent {
//    case increment
//    case decrement
//}
//
//struct CounterState: Equatable {
//    var state = 0
//}
//
//class CounterBloc: Bloc<CounterEvent, CounterState> {
//    init() {
//        super.init(intialState: CounterState())
//    }
//
//    override func mapEventToState(event: CounterEvent) -> CounterState {
//        switch event {
//        case .increment:
//            return CounterState(state: state.state + 1)
//        case .decrement:
//            return CounterState(state: state.state - 1)
//        }
//    }
//}
//
//public struct TestView: View {
//    @State private var bloc = CounterBloc()
//
//    public init() {}
//
//    public var body: some View {
//        BlocBuilder(cubit: bloc, buildWhen: { (prev, cur) -> Bool in
//            return prev != cur
//        }) { (state) in
//            return VStack {
//                Button(action: {
//                    print(state.state)
//                    //self.cubit.increment()
//                    self.bloc.add(event: .increment)
//                    //print("increment:", self.bloc.state.state)
//                }, label: {
//                    Text("Increment")
//                })
//                Button(action: {
//                    print(state.state)
//                    //self.cubit.increment()
//                    self.bloc.add(event: .decrement)
//                    //print("decrement:", self.bloc.state.state)
//                }, label: {
//                    Text("Decrement")
//                })
//                Button(action: {
//                    //self.cubit.close()
//                    self.bloc.close()
//                }, label: {
//                    Text("Cancel")
//                })
//            }
//        }
//    }
//}
