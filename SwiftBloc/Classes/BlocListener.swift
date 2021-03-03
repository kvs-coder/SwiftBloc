//
//  BlocListener.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.03.21.
//

import SwiftUI

public typealias BlocViewListener<S: Equatable> = (_ state: S) -> Void
public typealias BlocListenerCondition<S: Equatable> = (_ previous: S, _ current: S) -> Bool

public struct BlocListener<C: Cubit<S>, S: Equatable>: BlocListenerBase  {
    @ObservedObject internal var cubit: C

    private var state: S {
        return cubit.state
    }

    let listenWhen: BlocListenerCondition<S>?
    let listener: BlocViewListener<S>
    
    public var body: some View {
        return EmptyView()
    }

    public init(
        listener: @escaping BlocViewListener<S>,
        cubit: C,
        listenWhen: BlocListenerCondition<S>? = nil
    ) {
        self.listener = listener
        self.listenWhen = listenWhen
        self.cubit = cubit
    }
    
    public func listen() -> Self {
        listener(state)
        return self
    }
}

protocol BlocListenerBase: View {
    associatedtype S where S: Equatable
    associatedtype C where C: Cubit<S>
    
    var cubit: C { get }
    var listenWhen: BlocListenerCondition<S>? { get }
    
    func listen() -> Self
}
