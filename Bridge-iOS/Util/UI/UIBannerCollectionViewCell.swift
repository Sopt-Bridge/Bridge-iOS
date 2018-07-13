//
//  UIBannerCollectionViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 4..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerCollectionView: UIHomeBannerCollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
}

class UIBannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
