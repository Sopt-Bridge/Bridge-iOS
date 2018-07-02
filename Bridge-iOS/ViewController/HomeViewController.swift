//
//  HomeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    var colorList: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.blue, UIColor.black, UIColor.red]
    
    func presentToLoginView() {
        let viewIdentifier: String = "LoginViewController"
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as? LoginViewController
        {
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath: IndexPath = IndexPath(row: 1, section: 0)
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let fullyScrolledContentOffset:CGFloat = scrollView.frame.size.width * CGFloat(self.colorList.count - 1)
        if (scrollView.contentOffset.x >= fullyScrolledContentOffset) {
            let indexPath: IndexPath = IndexPath(row: 1, section: 0)
            bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
        else if (scrollView.contentOffset.x == 0) {
            let indexPath: IndexPath = IndexPath(row: self.colorList.count - 2, section: 0)
            bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
            cell.backgroundColor = self.colorList[indexPath.item]
            return cell
        }
        else if collectionView == self.contentsCollectionView {
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
}
