//
//  GitHubController.swift
//  DevUtilities
//
//  Created by Vittorio Picone on 05/06/2020.
//  Copyright © 2020 Vittorio Picone. All rights reserved.
//

import UIKit
import WebKit

class GitHubController: UIViewController, WKUIDelegate
{
    @IBOutlet var WebKit: WKWebView!
    override func loadView()
    {
        let webConfiguration = WKWebViewConfiguration()
        WebKit = WKWebView(frame: .zero, configuration: webConfiguration)
        WebKit.uiDelegate = self
        view = WebKit
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.github.com/VikSn0w/")
        let myRequest = URLRequest(url: myURL!)
        WebKit.load(myRequest)
        
        self.hideskeyboard()
    }
}
