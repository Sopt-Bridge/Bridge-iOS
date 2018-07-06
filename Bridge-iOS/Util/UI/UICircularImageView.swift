//
//  UICircularImageView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UICircularImageView: UIImageView {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}
