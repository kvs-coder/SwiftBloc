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
    @ObservedObject var bloc = CounterBloc()

    @State var isAlertCalled = false

    var body: some View {
        BlocBuilder(builder: { (state) in
            VStack {
                if state.count > 5 {
                    VStack {
                        Text("Hooora")
                        Button(action: {
                            self.bloc.add(event: .decrement)
                            self.bloc.add(event: .decrement)
                            self.bloc.add(event: .decrement)
                            self.bloc.add(event: .decrement)
                        }, label: {
                            Text("Reset")
                        })
                    }
                } else if state.count == -1 {
                    BlocListener(listener: { (state) in
                        print(state.count)
                        DispatchQueue.main.async {
                            self.isAlertCalled = true
                        }
                    }, cubit: self.bloc, listenWhen: { (prev, cur) -> Bool in
                        return prev == cur
                    })
                    .listen()
                } else {
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
                        Text("Count: \(state.count)")
                    }
                }
            }
        }, cubit: bloc, buildWhen: { (prev, cur) -> Bool in
            return prev == cur
        })
        .alert(isPresented: $isAlertCalled) {
            Alert(title: Text("Hi"), message: Text("Message"), dismissButton: .cancel({
                self.bloc.add(event: .increment)
                self.bloc.add(event: .increment)
            }))
        }
    }
}

struct BlocContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlocContentView()
    }
}
