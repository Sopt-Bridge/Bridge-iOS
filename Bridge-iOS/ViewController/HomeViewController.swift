//
//  HomeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var bannerCollectionView: UICollectionView!
    
    let identifierString: [String] = ["BannerViewCell", "NowTrendViewCell", "RecommendedViewCell", "RecentViewCell", "ContentsCell"]
    var colorList: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.blue, UIColor.black, UIColor.red]
    var timer: Timer!
    
    func presentToLoginView() {
        let viewIdentifier: String = "LoginViewController"
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as? LoginViewController
        {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func presentToProfileView() {
        let viewIdentifier: String = "ProfileViewController"
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as? LoginViewController
        {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func autoScrolling() {
        var index: Int = 0
        print("auto")
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
            let page: Int = Int(self.bannerCollectionView.contentOffset.x / self.bannerCollectionView.frame.size.width)
            index = (page + 1) % 5
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: index == 0 ? false : true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag == 0 {
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
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: // banner
            return self.colorList.count
        case 1: //
            return 4
        case 2: //
            return 4
        case 10:// base
            return 6 + self.identifierString.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell: UIBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! UIBannerCollectionViewCell
            cell.backgroundColor = self.colorList[indexPath.item]
            return cell
        case 1:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            return cell
        case 2:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            return cell
        case 3:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            return cell
        case 10:
            let index: Int = (indexPath.item < self.identifierString.count) ? indexPath.item : self.identifierString.count - 1
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierString[index], for: indexPath)
            if indexPath.item == 0 {
                self.bannerCollectionView = (cell as! BannerViewCell).bannerCollectionView
                let indexPath: IndexPath = IndexPath(row: 1, section: 0)
                self.bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
                self.autoScrolling()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 10 {
            let sizes: [CGSize] = [CGSize(width: 375, height: 176), CGSize(width: 375, height: 206), CGSize(width: 375, height: 206), CGSize(width: 375, height: 53), CGSize(width: 187, height: 150)]
            let index: Int = (indexPath.item < sizes.count) ? indexPath.item : sizes.count - 1
            return sizes[index]
        }
        else if collectionView.tag == 0 {
            return CGSize(width: 375, height: 176)
        }
        return CGSize(width: 168, height: 142)
    }
}
