//
//  UICustomTabBarItem.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UICustomTabBarItem: UITabBarItem {
    
    @IBInspectable var top: CGFloat = 0 {
        didSet {
            let inset = self.imageInsets
            self.imageInsets = UIEdgeInsets(top: self.top, left: inset.left, bottom: inset.bottom, right: inset.right)
        }
    }
    
    @IBInspectable var left: CGFloat = 0 {
        didSet {
            let inset = self.imageInsets
            self.imageInsets = UIEdgeInsets(top: inset.top, left: self.left, bottom: inset.bottom, right: inset.right)
        }
    }
    
    @IBInspectable var bottom: CGFloat = 0 {
        didSet {
            let inset = self.imageInsets
            self.imageInsets = UIEdgeInsets(top: inset.top, left: inset.left, bottom: self.bottom, right: inset.right)
        }
    }
    
    @IBInspectable var right: CGFloat = 0 {
        didSet {
            let inset = self.imageInsets
            self.imageInsets = UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: self.right)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let top = self.top
        let left = self.left
        let bottom = self.bottom
        let right = self.right
        
        self.imageInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.title = nil
    }
}
