//
//  ContentsViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import WebKit

class ContentsViewController: UIViewController {
    
    @IBOutlet weak var youtubeWebView: WKWebView!
    //https://www.youtube.com/embed/n5KzD4dPxMw
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL: URL = URL(string: "https://www.youtube.com/embed/n5KzD4dPxMw")!
        let myURLRequest: URLRequest = URLRequest(url: myURL)
        self.youtubeWebView.load(myURLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
