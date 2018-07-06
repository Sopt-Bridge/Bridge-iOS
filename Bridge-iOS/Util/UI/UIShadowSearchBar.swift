//
//  UIShadowSearchBar.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIShadowSearchBar: UISearchBar {

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
    
    @IBInspectable var shadowRadius: CGFloat = 2.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.clipsToBounds = false
        self.layer.shouldRasterize = true
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOffset = self.shadowOffset
    }
}
