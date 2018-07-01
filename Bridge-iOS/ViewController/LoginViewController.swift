//
//  LoginViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK:- IBAction methods
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedGoogleButton(_ sender: UIButton) {
    }
    
    @IBAction func didClickedFacebookButton(_ sender: UIButton) {
    
    }
    
    
    // MARK:- Override methdos
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
