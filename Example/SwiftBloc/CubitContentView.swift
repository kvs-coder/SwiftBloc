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
    var body: some View {
        BlocView(builder: { (cubit, state)  in
            VStack {
                Button(action: {
                    cubit.increment()
                }, label: {
                    Text("Increment")
                })
                Button(action: {
                    cubit.decrement()
                }, label: {
                    Text("Decrement")
                })
                Text("Count: \(state)")
            }
        }, cubit: CounterCubit())
    }
}

struct CubitContentView_Previews: PreviewProvider {
    static var previews: some View {
        CubitContentView()
    }
}
