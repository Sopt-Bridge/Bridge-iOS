//
//  UIShadowNavigationBar.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 9..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable class UIShadowNavigationBar: UINavigationBar {

    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        shadowImage = UIColor.white.image(rect: CGRect(x: 0, y: 0, width: 1, height: 1))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
