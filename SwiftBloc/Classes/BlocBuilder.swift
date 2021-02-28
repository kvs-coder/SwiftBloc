//
//  BlocBuilder.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 28.02.21.
//

import SwiftUI

public typealias BlocViewBuilder<State: Equatable, Content> = (_ state: State) -> Content
public typealias BlocBuilderCondition<State: Equatable> = (_ previous: State, _ current: State) -> Bool

public struct BlocBuilder<C: Cubit<S>, S: Equatable, Content: View>: BlocBuilderBase  {
    public let cubit: C
    public let buildWhen: BlocBuilderCondition<S>
    public let builder: BlocViewBuilder<S, Content>
    
    public var body: some View {
        return build(state: cubit.state)
    }
    
    public func build(state: S) -> Content {
        return builder(state)
    }
    
    public init(
        builder: @escaping BlocViewBuilder<S, Content>,
        cubit: C,
        buildWhen: @escaping BlocBuilderCondition<S>
    ) {
        self.builder = builder
        self.cubit = cubit
        self.buildWhen = buildWhen
    }
}

public protocol BlocBuilderBase: View {
    associatedtype S where S: Equatable
    associatedtype C where C: Cubit<S>
    associatedtype Content where Content: View
    
    var cubit: C { get }
    var buildWhen: BlocBuilderCondition<S> { get }
    
    func build(state: S) -> Content
    
    //func createState() -> BlocBuilderBaseState<C, S>
}
