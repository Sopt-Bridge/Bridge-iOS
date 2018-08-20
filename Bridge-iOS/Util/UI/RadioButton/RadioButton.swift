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
    @IBInspectable var isSelectedButton: Bool = false
    var radioButtonGroup: RadioButtonGroup?

    func select() {
        guard let title = titleLabel else { return }
        isSelectedButton = true

        DispatchQueue.main.async {
            let fontSize: CGFloat = title.font.pointSize
            self.setTitleColor(self.enableColor, for: .normal)
            if self.isBold {
                title.font = UIFont.boldSystemFont(ofSize: fontSize)
            }
        }
    }

    func deselect() {
        guard let title = titleLabel else { return }
        isSelectedButton = false

        DispatchQueue.main.async {
            let fontSize: CGFloat = title.font.pointSize
            self.setTitleColor(self.disableColor, for: .normal)
            if self.isBold {
                title.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let location: CGPoint = touches.first?.location(in: self) else { return }
        guard let group: RadioButtonGroup = radioButtonGroup else { return }
        if bounds.contains(location) {
            group.select(self)
        }
    }
}

