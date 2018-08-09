//
//  RadioButtonGroup.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit


/// 라디오 버튼들을 묶고 해당하는 작업만 하기
class RadioButtonGroup: UIView {

    @IBOutlet var radioButtons: [RadioButton] = []

    func select(_ sender: RadioButton) {
        radioButtons.forEach { (radioButton: RadioButton) in
            if radioButton == sender {
                radioButton.select()
            } else {
                radioButton.deselect()
            }
        }
    }

    func deselectAll() {
        radioButtons.forEach { (radioButton: RadioButton) in
            radioButton.deselect()
        }
    }

    override func layoutSubviews() {
        radioButtons.forEach { (radioButton: RadioButton) in
            radioButton.radioButtonGroup = self
        }
    }
}
