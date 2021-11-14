//
//  BlocView.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 03.03.21.
//

import SwiftUI

/**
 BlocViewBuilder
 - parameter state: current state.
 - returns: content view
 */
public typealias BlocViewBuilder<B: Base<S>, S: Equatable, Content: View> = (_ base: B) -> Content
/**
 BlocViewAction
 - parameter state: current state.
 */
public typealias BlocViewAction<B: Base<S>, S: Equatable> = (_ base: B) -> Void
/**
 A general protocol for the **BlocView** class.
 */
protocol BlocViewProtocol: View {
    associatedtype S where S: Equatable
    associatedtype B where B: Base<S>
    associatedtype Content where Content: View

    var base: B { get }

    func build(base: B) -> Content
}
/**
 A wrapper for a **View** conforming view providing BloC instance as **EnvironmentObject**.
 Expects **Cubit** (**Bloc** as well) conforming BloC component with **Equatable** state object.
 */
public struct BlocView<B: Base<S>, S: Equatable, Content: View>: BlocViewProtocol  {
    /**
     A cubit/bloc property which holds the custom business logic
     */
    @ObservedObject var base: B
    /**
     Extract the current state from a cubit/bloc
     */
    private var state: S {
        base.state
    }
    /**
     @ViewBuilder callback. Builds views based on the state.
     */
    private let builder: BlocViewBuilder<B, S, Content>
    /**
     (Optional) Custom action callback. Called every time the state is changed.
     */
    private let action: BlocViewAction<B, S>?
    /**
     Required property of View Protocol. Body will set the current cubit/bloc instance as **EnvironmentObject** if the instance
     is wrapped in an **ObservedObject** property wrapper in your View.
     */
    public var body: some View {
        build(base: base)
            .listen(base: base, action: action)
            .environmentObject(base)
    }
    /**
     BlocView constructor
     - parameter builder: builder callback.
     - parameter action: custom action callback. Optional
     - parameter cubit: cubit/bloc instance.
     */
    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<B, S, Content>,
                     action: BlocViewAction<B, S>? = nil,
                     base: B
    ) {
        self.builder = builder
        self.action = action
        self.base = base
    }
    /**
     Builds the view **Content** based on the state
     - parameter base: the **Bloc** or **Cubit** object.
     - returns: content view
     */
    func build(base: B) -> Content {
        builder(base)
    }
}
