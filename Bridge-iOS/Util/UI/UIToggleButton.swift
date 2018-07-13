//
//  UIToggleButton.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIToggleButton: UIButton {

    @IBInspectable var toggleOnImage: UIImage!
    @IBInspectable var toggleOffImage: UIImage!
    
    var isOn: Bool = false
    var toggleOnCallback: (() -> (Void))!
    var toggleOffCallback: (() -> (Void))!
    
    func setDefaultState(isOn: Bool) {
        self.isOn = isOn
        if self.isOn {
            self.imageView?.image = self.toggleOnImage
        }
        else {
            self.imageView?.image = self.toggleOffImage
        }
    }
    
    @objc func didClickSelf(_ sender: UIButton) {
        
        if user.token == nil {
            return
        }
        
        self.isOn = !self.isOn
        if self.isOn {
            self.setImage(self.toggleOnImage, for: .normal)
            self.toggleOnCallback()
        }
        else {
            self.setImage(self.toggleOffImage, for: .normal)
            self.toggleOffCallback()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(didClickSelf(_:)), for: .touchUpInside)
//        self.target(forAction: #selector(didClickSelf), withSender: self)
    }
    
//    override func didAddSubview(_ subview: UIView) {
//        super.didAddSubview(subview)
    
//    }
}
