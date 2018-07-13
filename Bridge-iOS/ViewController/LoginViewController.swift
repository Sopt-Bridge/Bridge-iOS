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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedFacebookButton(_ sender: UIButton) {
        
        let manager: FBSDKLoginManager = FBSDKLoginManager.init()
        manager.logIn(withReadPermissions: ["public_profile"], from: self) { (loginResult, error) in
            if let result = loginResult {
                let uid: String = result.token.userID
            
                let request: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"picture.type(large), first_name, last_name"], tokenString: result.token.tokenString, version: nil, httpMethod: "GET")

                request.start(completionHandler: { (connection, result, error) in
                    let group = DispatchGroup()
                    
                    if let value: [String: Any] = result as? [String: Any] {
                        group.enter()
                        LoginService.postLogin(userUuid: uid, userName: "\(value["last_name"]) \(value["first_name"])", completion: { (data) in
                            
                            user.userIndex = data.userIdx
                            user.token = data.token
                            guard let firstName = value["first_name"] as? String else {
                                return
                            }
                            guard let lastName = value["last_name"] as? String else {
                                return
                            }
                            user.fullName = "\(lastName) \(firstName)"
                            if let url = ((value["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                                user.pictureAddress = url
                                AlamoUtil.loadImage(url: url, completion: { (image) in
                                    user.picture = Profile(frame: CGRect(x: 0, y: 0, width: 58, height: 29), transform: CGAffineTransform.identity, imagetoData: image!)
                                    group.leave()
                                })
                            }
                            
                            group.notify(queue: .main) {
                                print("logined data : \(user)")
                                saveUserData()
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                            NotificationCenter.default.post(name: .RefreshNavigationItem, object: nil)
                        })
                    }
                    else {
                        print("error: \(error!)")
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
