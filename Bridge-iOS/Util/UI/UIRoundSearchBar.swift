//
//  UIRoundSearchBar.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 5..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundSearchBar: UISearchBar {

    var textField: UITextField?
    var imageView: UIImageView?
    
    @IBInspectable var cornerRadius: CGFloat = 18 {
        didSet {
            if let field: UITextField = self.textField {
                field.layer.cornerRadius = self.cornerRadius
            }
            else {
                print("UITextField is Not initialized yet.")
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            if let field: UITextField = self.textField {
                field.layer.borderColor = self.borderColor.cgColor
            }
            else {
                print("UITextField is Not initialized yet.")
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            if let field: UITextField = self.textField {
               field.layer.borderWidth = self.borderWidth
            }
            else {
                print("UITextField is Not initialized yet.")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for view in self.subviews {
            for subview in view.subviews {
                if subview.isKind(of: UITextField.self) {
                    self.textField = subview as? UITextField
                }
                else if subview.isKind(of: UIImageView.self) {
                    self.imageView = subview as? UIImageView
                    if let image: UIImageView = self.imageView {
                        image.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        if let field: UITextField = self.textField {
            field.clipsToBounds = true
            field.layer.masksToBounds = true
            field.layer.cornerRadius = self.cornerRadius
            field.layer.borderColor = self.borderColor.cgColor
            field.layer.borderWidth = self.borderWidth
        }
        else {
            print("UITextField is Not initialized yet.")
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
