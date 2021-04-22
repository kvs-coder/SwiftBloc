//
//  SuccessViewController.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 22.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI

final class SuccessViewController: UIHostingController<SuccessView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SuccessView())
    }
}
