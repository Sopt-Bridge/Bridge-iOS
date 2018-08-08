//
//  RadioButton.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 7..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

/// 버튼 눌렀을 때 일어나는일 (색 변경, 볼드 뭐 그런거)
class RadioButton: UIButton {

    @IBInspectable var enableColor: UIColor = UIColor.clear
    @IBInspectable var disableColor: UIColor = UIColor.clear
    @IBInspectable var isBold: Bool = false
    @IBInspectable var isItalic: Bool = false
    
}

