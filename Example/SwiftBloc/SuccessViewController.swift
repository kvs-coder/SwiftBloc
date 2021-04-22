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

    @IBAction func markTapped(_ sender: UIBarButtonItem) {
        showAlertViewController()
    }

    private func showAlertViewController() {
        let alertViewController = UIAlertController(
            title: "Good",
            message: "I was called from Hosted View Controller with SwiftUI Content",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addAction(cancelAction)
        present(alertViewController, animated: true)
    }
}
