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
public typealias BlocViewBuilder<C: Cubit<S>, S: Equatable, Content: View> = (_ cubit: C, _ state: S) -> Content
/**
 BlocViewAction
 - parameter state: current state.
 */
public typealias BlocViewAction<C: Cubit<S>, S: Equatable> = (_ cubit: C, _ state: S) -> Void
/**
 A general protocol for the **BlocView** class.
 */
protocol BlocViewProtocol: View {
    associatedtype S where S: Equatable
    associatedtype C where C: Cubit<S>
    associatedtype Content where Content: View

    var cubit: C { get }

    func build(cubit: C, state: S) -> Content
}
/**
 A wrapper for a **View** conforming view providing BloC instance as **EnvironmentObject**.
 Expects **Cubit** (**Bloc** as well) conforming BloC component with **Equatable** state object.
 */
public struct BlocView<C: Cubit<S>, S: Equatable, Content: View>: BlocViewProtocol  {
    /**
     A cubit/bloc property which holds the custom buisiness logic
     */
    @ObservedObject var cubit: C
    /**
     Extract the current state from a cubit/bloc
     */
    private var state: S {
        return cubit.state
    }
    /**
     @ViewBuilder callback. Builds views based on the state
     */
    private let builder: BlocViewBuilder<C, S, Content>
    /**
     (Optional) Custom action callback. Called everytime when state changes
     */
    private let action: BlocViewAction<C, S>?
    /**
     Required property of View Protocol. Body will set the current cubit/bloc instance as **EnvironmentObject** if the instance
     is wrapped in **ObservedObject** property wrapper in your View.
     */
    public var body: some View {
        build(cubit: cubit, state: state)
            .listen(cubit: cubit, state: state, action: action)
            .environmentObject(cubit)
    }
    /**
     BlocView constructor
     - parameter builder: builder callback.
     - parameter action: custom action callback. Optional
     - parameter cubit: cubit/bloc instance..
     */
    public init(
        @ViewBuilder builder: @escaping BlocViewBuilder<C, S, Content>,
                     action: BlocViewAction<C, S>? = nil,
                     cubit: C
    ) {
        self.builder = builder
        self.action = action
        self.cubit = cubit
    }
    /**
     Builds the view **Content** based on the state
     - parameter state: current state.
     - returns: content view
     */
    func build(cubit: C, state: S) -> Content {
        builder(cubit, state)
    }
}
