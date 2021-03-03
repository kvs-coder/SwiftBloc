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
        @ViewBuilder builder: @escaping BlocViewBuilder<S, Content>,
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
