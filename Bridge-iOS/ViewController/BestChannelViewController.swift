//
//  BestChannelViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 6..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class BestChannelViewController: UIViewController {

    @IBAction func didClickedBackButton(_ sender: UIBarButtonItem) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
