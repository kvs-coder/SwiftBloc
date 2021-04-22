//
//  FunnyView.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 22.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

struct FunnyView: UIViewRepresentable {
    typealias UIViewType = UIImageView

    func makeUIView(context: Context) -> UIImageView {
        let image = UIImage(named: "smile")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
