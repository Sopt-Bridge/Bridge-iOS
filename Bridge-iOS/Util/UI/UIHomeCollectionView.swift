//
//  UIHomeCollectionView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIHomeCollectionView: UICollectionView {

    @objc func reloadCollectionView() {
        self.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name.HomeReloadAllCollectionView, object: nil)
    }
}
