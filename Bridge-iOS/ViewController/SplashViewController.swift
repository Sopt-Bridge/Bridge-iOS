//
//  SplashViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 13..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController {

    @IBOutlet weak var splashView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = UIImage(gifName: "splash.gif")
        let gifImageView = UIImageView(gifImage: gif, loopCount: 1)
        gifImageView.frame = self.splashView.bounds
        gifImageView.delegate = self
        gifImageView.startAnimating()
        gifImageView.contentMode = .scaleAspectFit
        self.splashView.addSubview(gifImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SplashViewController: SwiftyGifDelegate {
    
    func gifDidStop(sender: UIImageView) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstTabbar") as? UITabBarController
        {
            self.present(vc, animated: false, completion: nil)
//            self.showDetailViewController(vc, sender: nil)
        }
    }
}
