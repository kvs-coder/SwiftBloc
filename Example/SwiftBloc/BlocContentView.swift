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
    var body: some View {
        NavigationView {
            BlocView(builder: { (bloc) in
                CounterView()
                    .alert(isPresented: bloc.shouldShowAlertBinding) {
                        Alert(
                            title: Text("Hi"),
                            message: Text("Message"),
                            dismissButton: .cancel {
                                for _ in 0..<6 {
                                    bloc.add(event: .increment)
                                }
                            }
                        )
                    }
            }, action: { (bloc) in
                print(bloc.state.count)
            }, base: CounterBloc())
            .navigationBarTitle(Text("Bloc"), displayMode: .inline)
        }
    }
}

struct CounterView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        if bloc.state.count > 5 {
            LimitView()
        } else {
            OperationView()
        }
    }
}

struct LimitView: View {
    @EnvironmentObject var bloc: CounterBloc

    var body: some View {
        VStack {
            Text("Hooora")
            Button(action: {
                for _ in 0..<6 {
                    bloc.add(event: .decrement)
                }
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
                bloc.add(event: .increment)
            }, label: {
                Text("Send Increment event")
            })
            Button(action: {
                bloc.add(event: .decrement)
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
