//
//  WebViewController.swift
//  SwiftBloc_Example
//
//  Created by Kachalov, Victor on 22.04.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        let url = URL(string: "https://www.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
