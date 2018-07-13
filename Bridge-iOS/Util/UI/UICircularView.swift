//
//  UICircularView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UICircularView: UIView {

    @IBInspectable var cornerRaidus: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = self.cornerRaidus
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRaidus
    }
}
