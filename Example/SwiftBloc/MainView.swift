//
//  MainView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 01.03.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                CubitContentView()
                .tabItem {
                    Text("Cubit")
                    Image(systemName: "arrow.counterclockwise")
                }
                .navigationBarTitle("Cubit")
                BlocContentView()
                .tabItem {
                    Text("Bloc")
                    Image(systemName: "cube")
                }
                .navigationBarTitle("Bloc")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
