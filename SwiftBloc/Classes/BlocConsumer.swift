//
//  BlocConsumer.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.03.21.
//

import SwiftUI

public struct BlocConsumer<S: Equatable, Content: View>: BlocConsumerBase {
    @EnvironmentObject internal var cubit: Cubit<S>

    private var state: S {
        return cubit.state
    }

    let buildWhen: BlocBuilderCondition<S>?
    let listenWhen: BlocListenerCondition<S>?
    let builder: BlocViewBuilder<S, Content>
    let listener: BlocViewListener<S>
    
    public var body: some View {
        return build(state: state)
    }

    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<S, Content>,
                     buildWhen: BlocBuilderCondition<S>? = nil,
                     listener: @escaping BlocViewListener<S>,
                     listenWhen: BlocListenerCondition<S>? = nil
    ) {
        self.builder = builder
        self.buildWhen = buildWhen
        self.listener = listener
        self.listenWhen = listenWhen
    }

    func build(state: S) -> Content {
        return builder(state)
    }
    
    func listen() {
        listener(state)
    }
}

protocol BlocConsumerBase: View {
    associatedtype S where S: Equatable
    associatedtype Content where Content: View
    
    var cubit: Cubit<S> { get }
    var listenWhen: BlocListenerCondition<S>? { get }
    
    func build(state: S) -> Content
    func listen()
}
