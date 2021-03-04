//
//  Extensions+View.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 04.03.21.
//

import SwiftUI

extension View {
    func listen<S>(state: S, action: BlocViewAction<S>?) -> some View {
        action?(state)
        return self
    }
}
