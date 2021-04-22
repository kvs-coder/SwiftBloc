//
//  MainView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 01.03.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import SwiftBloc

struct MainView: View {
    var body: some View {
        TabView {
            CubitContentView()
                .tabItem {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Cubit")
                }
            BlocContentView()
                .tabItem {
                    Image(systemName: "cube")
                    Text("Bloc")
                }
            WebView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Web")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
