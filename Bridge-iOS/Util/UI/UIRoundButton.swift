//
//  UIRoundButton.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 5..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundButton: UIButton {
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
