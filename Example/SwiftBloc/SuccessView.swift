//
//  SuccessView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 22.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    @State var isAlertPresented = false

    var body: some View {
        VStack(
            spacing: 20.0,
            content: {
                Text("I am an amazing SwiftUI Text")
                Button("Call alert") {
                    isAlertPresented = true
                }
            }
        )
        .alert(
            isPresented: $isAlertPresented,
            content: {
                Alert(
                    title: Text("Perfect"),
                    message: Text("I was called from SwiftUI content in Hosted ViewController"),
                    dismissButton: .cancel()
                )
            }
        )
    }
}
