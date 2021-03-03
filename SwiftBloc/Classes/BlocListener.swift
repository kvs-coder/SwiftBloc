//
//  BlocListener.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 01.03.21.
//

import SwiftUI

//public typealias BlocViewListener<S: Equatable> = (_ state: S) -> Void
public typealias BlocListenerCondition<S: Equatable> = (_ previous: S, _ current: S) -> Bool

public struct BlocListener<S: Equatable>: BlocListenerBase  {
    @EnvironmentObject internal var cubit: Cubit<S>

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
        listenWhen: BlocListenerCondition<S>? = nil
    ) {
        self.listener = listener
        self.listenWhen = listenWhen
    }
    
    public func listen() -> Self {
        listener(state)
        return self
    }
}

protocol BlocListenerBase: View {
    associatedtype S where S: Equatable
    
    var cubit: Cubit<S> { get }
    var listenWhen: BlocListenerCondition<S>? { get }
    
    func listen() -> Self
}
