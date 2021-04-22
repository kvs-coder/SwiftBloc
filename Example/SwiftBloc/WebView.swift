//
//  WebView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 22.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

struct WebView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Web", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "NavigationWebViewController")
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
