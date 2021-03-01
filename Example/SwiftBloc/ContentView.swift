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
    @ObservedObject var cubit = CounterCubit()
    //@State private var bloc = CounterBloc()

    var body: some View {
        VStack {
            Button(action: {
                self.cubit.increment()
            }, label: { Text("\(cubit.state)") })
        }
        //TestView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}