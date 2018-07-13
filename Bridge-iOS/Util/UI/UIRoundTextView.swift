//
//  UIRoundTextView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 7..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundTextView: UITextView {

    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.cornerRadius
    }
}
