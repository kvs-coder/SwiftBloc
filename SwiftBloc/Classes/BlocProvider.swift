//
//  BlocProvider.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 03.03.21.
//

import SwiftUI

public typealias BlocViewProvider<Content: View> = () -> Content

public struct BlocProvider<S: Equatable, Content: View>: BlocProviderBase {
    internal var cubit: Cubit<S>

    private let view: BlocViewProvider<Content>

    public var body: some View {
        view().environmentObject(cubit)
    }

    public init(
        cubit: Cubit<S>,
        @ViewBuilder view: @escaping BlocViewProvider<Content>
    ) {
        self.cubit = cubit
        self.view = view
    }
}

protocol BlocProviderBase: View {
    associatedtype S where S: Equatable
    
    var cubit: Cubit<S> { get }
}
