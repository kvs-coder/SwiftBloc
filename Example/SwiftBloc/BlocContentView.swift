//
//  BlocContentView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 01.03.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

struct BlocContentView: View {
    @ObservedObject var bloc = CounterBloc()

    var body: some View {
        VStack {
            Button(action: {
                self.bloc.add(event: .increment)
            }, label: {
                Text("Send Increment event")
            })
            Button(action: {
                self.bloc.add(event: .decrement)
            }, label: {
                Text("Send Decrement event")
            })
            Text("Count: \(bloc.state.count)")
        }
    }
}

struct BlocContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlocContentView()
    }
}
