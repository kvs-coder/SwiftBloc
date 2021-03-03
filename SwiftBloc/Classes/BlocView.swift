//
//  BlocView.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 03.03.21.
//

import SwiftUI

public typealias BlocViewBuilder<S: Equatable, Content: View> = (_ state: S) -> Content

public struct BlocView<C: Cubit<S>, S: Equatable, Content: View>: BlocViewProtocol  {
    internal var cubit: C

    private var state: S {
        return cubit.state
    }

    let builder: BlocViewBuilder<S, Content>

    public var body: some View {
        build(state: state).environmentObject(cubit)
    }

    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<S, Content>,
                     cubit: C
    ) {
        self.builder = builder
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
