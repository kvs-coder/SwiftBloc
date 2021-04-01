//
//  Extensions+View.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 04.03.21.
//

import SwiftUI

extension View {
    func listen<B: Base<S>, S: Equatable>(
        base: B,
        action: BlocViewAction<B, S>?
    ) -> some View {
        action?(base)
        return self
    }
}
