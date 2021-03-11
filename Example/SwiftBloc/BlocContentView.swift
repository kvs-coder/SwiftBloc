//
//  BlocContentView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 01.03.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import SwiftBloc

struct BlocContentView: View {
    @State var isAlertCalled = false

    var body: some View {
        BlocView(builder: { (bloc, state) in
            VStack {
                if state.count > 5 {
                    LimitView()
                } else {
                    OperationView()
                }
            }
            .alert(isPresented: self.$isAlertCalled) {
                Alert(title: Text("Hi"), message: Text("Message"), dismissButton: .cancel({
                    bloc.add(event: .increment)
                }))
            }
        }, action: { (_, state) in
            print(state.count)
            if state.count < -1 {
                DispatchQueue.main.async {
                    self.isAlertCalled = true
                }
            }
        }, cubit: CounterBloc())
    }
}

struct LimitView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        VStack {
            Text("Hooora")
            Button(action: {
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
                self.bloc.add(event: .decrement)
            }, label: {
                Text("Reset")
            })
        }
    }
}

struct OperationView: View {
    @EnvironmentObject var bloc: CounterBloc

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
