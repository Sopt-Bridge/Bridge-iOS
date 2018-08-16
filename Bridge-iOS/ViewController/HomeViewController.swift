//
//  HomeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) {
            return cell
        }
        return UICollectionViewCell()
    }
}
