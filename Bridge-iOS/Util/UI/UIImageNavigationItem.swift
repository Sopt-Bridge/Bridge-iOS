//
//  UIImageNavigationItem.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageNavigationItem: UINavigationItem {
    
    @objc func showDetailToLoginView() {
        if let rvc = UIApplication.shared.delegate?.window??.rootViewController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            {
                rvc.showDetailViewController(vc, sender: nil)
            }
        }
    }
    
    func addLoginButton() {
        self.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "home_not_login_btn"), style: .plain, target: self, action: #selector(showDetailToLoginView))
        self.leftBarButtonItem?.tintColor = UIColor(rgb: 0x9A9A9A)
    }
    
    @objc func showDetailToProfileView() {
        if let rvc = UIApplication.shared.delegate?.window??.rootViewController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            {
                rvc.showDetailViewController(vc, sender: nil)
            }
        }
    }
    
    func addProfileButton() {
        self.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mypage_btn_small"), style: .plain, target: self, action: #selector(showDetailToProfileView))
        self.leftBarButtonItem?.tintColor = UIColor(rgb: 0x9A9A9A)
    }
    
    @objc func setButton() {
        if user.token == nil {
            addLoginButton()
        }
        else {
            addProfileButton()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = #imageLiteral(resourceName: "logo")
        imageView.image = image
        self.titleView = imageView
        setButton()
        NotificationCenter.default.addObserver(self, selector: #selector(setButton), name: NSNotification.Name.RefreshNavigationItem, object: nil)
    }
}
