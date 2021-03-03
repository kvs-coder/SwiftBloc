//
//  BlocView.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 03.03.21.
//

import SwiftUI

public typealias BlocViewBuilder<S: Equatable, Content: View> = (_ state: S) -> Content
public typealias BlocViewListener<S: Equatable> = (_ state: S) -> Void

public struct BlocView<C: Cubit<S>, S: Equatable, Content: View>: BlocViewProtocol  {
    var cubit: C

    private var state: S {
        return cubit.state
    }

    private let builder: BlocViewBuilder<S, Content>
    private let listener: BlocViewListener<S>?

    public var body: some View {
        build(state: state)
            .listen(state: state, listener: listener)
            .environmentObject(cubit)
    }

    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<S, Content>,
                     listener: BlocViewListener<S>? = nil,
                     cubit: C
    ) {
        self.builder = builder
        self.listener = listener
        self.cubit = cubit
    }

    func build(state: S) -> Content {
        builder(state)
    }
}

protocol BlocViewProtocol: View {
    associatedtype S where S: Equatable
    associatedtype C where C: Cubit<S>
    associatedtype Content where Content: View

    var cubit: C { get }

    func build(state: S) -> Content
}

extension View {
    func listen<S>(state: S, listener: BlocViewListener<S>?) -> some View {
        listener?(state)
        return self
    }
}
