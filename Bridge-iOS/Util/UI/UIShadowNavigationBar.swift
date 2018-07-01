//
//  UIShadowNavigationBar.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIShadowNavigationBar: UINavigationBar {

    @IBInspectable var shadowColor: UIColor = UIColor.lightGray {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.8 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: Float = 2.0 {
        didSet {
            self.layer.shadowRadius = CGFloat(self.shadowRadius)
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.masksToBounds = false
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowRadius = CGFloat(self.shadowRadius)
        self.layer.shadowOffset = self.shadowOffset
    }
}
