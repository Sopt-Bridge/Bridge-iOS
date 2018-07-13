//
//  UICustomToolBar.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 10..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UICustomToolBar: UIView {

    @IBOutlet var buttons: [UIButton]!
    
    var currentButton: Int = 0
    let enableColor: UIColor = UIColor(rgb: 0xE943AD)
    let disableColor: UIColor = UIColor(rgb: 0xD1D1D1)
    
    func setButtonState() {
        for i in 0 ..< buttons.count {
            if i == currentButton {
                self.buttons[i].setTitleColor(self.enableColor, for: .normal)
            }
            else {
                self.buttons[i].setTitleColor(self.disableColor, for: .normal)
            }
        }
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        if self.currentButton == sender.tag {
            return
        }
        self.currentButton = sender.tag
        setButtonState()
        NotificationCenter.default.post(name: .HomeCategoryChanged, object: nil, userInfo: ["category": self.currentButton])
    }
}
