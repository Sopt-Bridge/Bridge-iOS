//
//  UIImageNavigationItem.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageNavigationItem: UINavigationItem {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "BridgeLogo")
        imageView.image = image
        
        self.titleView = imageView
    }
}
