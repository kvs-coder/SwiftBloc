//
//  ViewController.swift
//  SwiftBloc
//
//  Created by v.kachalov on 02/27/2021.
//  Copyright (c) 2021 v.kachalov. All rights reserved.
//

import UIKit
import SwiftBloc
import SwiftUI

struct ContentView: View {
    private let cubit = CounterCubit()
    private let bloc = CounterBloc()

    var body: some View {
        VStack {
            Button(action: {
                //self.cubit.increment()
                self.bloc.add(event: .increment)
                print("increment:", self.bloc.state.state)
            }, label: {
                Text("Increment")
            })
            Button(action: {
                //self.cubit.increment()
                self.bloc.add(event: .decrement)
                print("decrement:", self.bloc.state.state)
            }, label: {
                Text("Decrement")
            })
            Button(action: {
                //self.cubit.close()
            }, label: {
                Text("Cancel")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
