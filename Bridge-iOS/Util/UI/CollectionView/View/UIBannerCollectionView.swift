//
//  UIBannerCollectionView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 19..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIBannerCollectionView: UICollectionView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
    }
}

extension UIBannerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
        return cell
    }
}
