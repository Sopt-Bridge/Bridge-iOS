//
//  HomeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let collectionViewIdentifiers: [String] = ["BannerCollectionViewCell"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        collectionViewIdentifiers.forEach { (identifier) in
            if let dequeuedCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? UIHomeViewCollectionViewCell {
                cell = dequeuedCell
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGSize = UIScreen.main.bounds.size
        switch collectionView.distinctIdentifier {
        case UIBannerCollectionView.distinctIdentifier:
            var _ = screenSize.width

            return CGSize()
        default:
            break
        }
        return CGSize.zero
    }
}
