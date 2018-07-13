//
//  UIHomeBannerCollectionView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIHomeBannerCollectionView: UICollectionView {

    var timer: Timer!
    var pageControl: UIPageControl!
    
    func autoScrolling() {
        if self.timer != nil {
            return
        }
        
        var index: Int = 0
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
            index = Int(self.contentOffset.x / self.frame.size.width)
            index = (index + 1) % 4
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            self.scrollToItem(at: indexPath, at: .left, animated: true)
            self.pageControl.currentPage = index
        })
    }
    
    @objc func reloadCollectionView() {
        self.reloadData()
        self.autoScrolling()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name.HomeReloadAllCollectionView, object: nil)
    }
}
