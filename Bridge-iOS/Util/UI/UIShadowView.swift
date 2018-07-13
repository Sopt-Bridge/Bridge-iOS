//
//  UIShadowView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIShadowView: UIView {

    @IBInspectable var shadowColor: UIColor = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.8
    @IBInspectable var shadowRadius: CGFloat = 2.0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0)
    @IBInspectable var shadowCornerRadius: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.shadowCornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = self.shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = self.shadowOffset
        shadowLayer.shadowOpacity = self.shadowOpacity
        shadowLayer.shadowRadius = self.shadowRadius
        self.layer.insertSublayer(shadowLayer, at: 0)
        
    }
}
