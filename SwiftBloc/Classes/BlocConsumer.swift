//
//  BlocConsumer.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.03.21.
//

import SwiftUI

public struct BlocConsumer<C: Cubit<S>, S: Equatable, Content: View>: View {
    @ObservedObject internal var cubit: C

    private var state: S {
        return cubit.state
    }

    let buildWhen: BlocBuilderCondition<S>?
    let listenWhen: BlocListenerCondition<S>?
    let builder: BlocViewBuilder<S, Content>
    let listener: BlocViewListener<S>
    
    public var body: some View {
        //listen()
        return build(state: state)
    }

    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<S, Content>,
                     buildWhen: BlocBuilderCondition<S>? = nil,
                     cubit: C,
                     listener: @escaping BlocViewListener<S>,
                     listenWhen: BlocListenerCondition<S>? = nil
    ) {
        self.builder = builder
        self.buildWhen = buildWhen
        self.cubit = cubit
        self.listener = listener
        self.listenWhen = listenWhen
    }

    func build(state: S) -> Content {
        return builder(state)
    }
    
//    public func listen() {
//        listener(state)
//    }
}
