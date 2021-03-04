//
//  ViewController.swift
//  SwiftBloc
//
//  Created by Victor Kachalov on 02/27/2021.
//  Copyright (c) 2021 Victor Kachalov. All rights reserved.
//

import SwiftBloc
import SwiftUI

struct CubitContentView: View {
    @ObservedObject var cubit = CounterCubit()

    var body: some View {
        BlocView(builder: { (state)  in
            VStack {
                Button(action: {
                    self.cubit.increment()
                }, label: {
                    Text("Increment")
                })
                Button(action: {
                    self.cubit.decrement()
                }, label: {
                    Text("Decrement")
                })
                Text("Count: \(state)")
            }
        }, cubit: cubit)
    }
}

struct CubitContentView_Previews: PreviewProvider {
    static var previews: some View {
        CubitContentView()
    }
}
