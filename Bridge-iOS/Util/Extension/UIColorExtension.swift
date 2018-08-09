//
//  UIColorExtension.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 10..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

extension UIColor {

    func image(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        guard let ctx = UIGraphicsGetCurrentContext() else { return UIImage() }
        self.setFill()
        ctx.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
