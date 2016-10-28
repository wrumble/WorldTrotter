//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Wayne Rumble on 12/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation
import WebKit
import UIKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        super.loadView()
        webView = WKWebView()
        self.view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://github.com/wrumble?tab=repositories")
        let req = NSURLRequest(URL: url!)
        self.webView!.loadRequest(req)
    }
    
}