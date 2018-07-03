//
//  LoginViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK:- IBAction methods
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedGoogleButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func didClickedFacebookButton(_ sender: UIButton) {
        
        let manager: FBSDKLoginManager = FBSDKLoginManager.init()
        manager.logIn(withReadPermissions: ["public_profile"], from: self) { (loginResult, error) in
            if let result = loginResult {
                let uid = result.token.userID // 이거 서버에 던져주기
                print("uid: \(uid)")
                let request: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture.type(large), name"], tokenString: result.token.tokenString, version: nil, httpMethod: "GET")
                
                request.start(completionHandler: { (connection, result, error) in
                    if(error == nil)
                    {
                        print("result \(result)")
                    }
                    else
                    {
                        print("error \(error)")
                    }
                })
            }
        }
    }
    
    // MARK:- Override methdos
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().signOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- GoogleSignInUIDelegate
extension LoginViewController: GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
