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
    var timer: Timer!
    
    func presentToLoginView() {
        let viewIdentifier: String = "LoginViewController"
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as? LoginViewController
        {
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func autoScrolling() {
        var index: Int = 0
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
            index = (index + 1) % 4
            let indexPath: IndexPath = IndexPath(row: index, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath: IndexPath = IndexPath(row: 1, section: 0)
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        autoScrolling()
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
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
        default:
            return UICollectionViewCell()
        }
    }
}
