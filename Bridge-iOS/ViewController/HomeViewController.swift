//
//  HomeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var hotCollectionView: UICollectionView!
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var otherCollectionView: UICollectionView!
    
    var bannerCollectionView: UIHomeBannerCollectionView!
    var pageControl: UIPageControl!

    let identifierString: [String] = ["BannerViewCell", "NowTrendViewCell", "RecommendedViewCell", "RecentViewCell", "ContentsCell"]
    var colorList: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.blue, UIColor.black, UIColor.red]
    
    var trendingDatas: [ContentData] = []
    var recommendedDatas: [ContentData] = []
    var recentDatas: [ContentData] = []
    var likeDatas: [ContentData] = []
    var viewCountDatas: [ContentData] = []
    var bannerDatas: [ContentData] = []
    var currentCategory: Int = 0
    var selectedContentData: ContentData?
    
    let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
    
    // MARK:- UI methods
    func initActionSheet() {
        let uploadDateAction: UIAlertAction = UIAlertAction(title: "Upload date", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "Upload date"
            self.reloadHomeView()
        })
        
        let viewCountAction: UIAlertAction = UIAlertAction(title: "View count", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "View count"
            self.reloadHomeView()
        })
        
        let ratingAction: UIAlertAction = UIAlertAction(title: "Rating", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "Rating"
            self.reloadHomeView()
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        uploadDateAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        viewCountAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        ratingAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: 0xE31C9E), forKey: "titleTextColor")
        
        self.actionSheet.addAction(uploadDateAction)
        self.actionSheet.addAction(viewCountAction)
        self.actionSheet.addAction(ratingAction)
        self.actionSheet.addAction(cancelAction)
    }
    
    // MARK:- IBAction methods
    @IBAction func didClickedSortButton(_ sender: UIButton) {
        self.present(self.actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func didClickedUserButton(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK:- Show detail methods
    func showDetailToVideoPlayer() {
//        if let rvc = UIApplication.shared.delegate?.window??.rootViewController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentsViewController") as? ContentsViewController
            {
                vc.contentData = self.selectedContentData
                self.showDetailViewController(vc, sender: nil)
            }
//        }
    }
    
    func showDetailToImageViewer() {
//        if let rvc = UIApplication.shared.delegate?.window??.rootViewController {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageContentsViewController") as? ImageContentsViewController
            {
                vc.contenData = self.selectedContentData
                self.showDetailViewController(vc, sender: nil)
            }
//        }
    }
    
    // MARK:- Reload methdos
    @objc func didChangeCategory(note: NSNotification) {
        if let category = note.userInfo?["category"] as? Int {
            self.currentCategory = category
            reloadHomeView()
        }
    }
    
    func reloadHotCategory() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                let group = DispatchGroup()
                
                group.enter()
                HomeService.getTrending(category: 0) { (datas) in
                    self.trendingDatas = datas
                    for i in 0 ..< 4 {
                        self.bannerDatas.append(datas[i])
                    }
                    self.trendingDatas.removeFirst(4)
                    group.leave()
                }
                
                group.enter()
                HomeService.getRecommended { (datas) in
                    self.recommendedDatas = datas
                    group.leave()
                }
                
                group.enter()
                HomeService.getRecent(category: 0, page: 0) { (datas) in
                    self.recentDatas = datas
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    self.hotCollectionView.reloadData()
                    NotificationCenter.default.post(name: .HomeReloadAllCollectionView, object: nil)
                }
            }
        }
    }
    
    func reloadHomeView() {
        if self.currentCategory == 0 { // Hot 일때
            self.otherView.isHidden = true
            self.hotCollectionView.isHidden = false
            self.reloadHotCategory()
            return
        }
        
        self.hotCollectionView.isHidden = true
        self.otherView.isHidden = false
        switch self.sortLabel.text {
        case "Upload date":
            HomeService.getRecent(category: self.currentCategory, page: 0) { (datas) in
                self.recentDatas = datas
                self.otherCollectionView.reloadData()
            }
            break
        case "View count":
            HomeService.getViewOrdered(category: self.currentCategory, page: 0) { (datas) in
                self.viewCountDatas = datas
                self.otherCollectionView.reloadData()
            }
            break
        case "Rating":
            HomeService.getLikes(category: self.currentCategory, page: 0) { (datas) in
                self.likeDatas = datas
                self.otherCollectionView.reloadData()
            }
            break
        default:
            break
        }
    }
    
    // MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: .RefreshNavigationItem, object: nil)
        self.initActionSheet()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeCategory), name: NSNotification.Name.HomeCategoryChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadHotCategory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width) % 4
        self.pageControl.currentPage = page
        if scrollView.tag == 0 {
            let fullyScrolledContentOffset:CGFloat = scrollView.frame.size.width * CGFloat(self.bannerDatas.count - 1)
            if (scrollView.contentOffset.x >= fullyScrolledContentOffset) {
                let indexPath: IndexPath = IndexPath(row: page, section: 0)
                bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }
            else if (scrollView.contentOffset.x == 0) {
                let indexPath: IndexPath = IndexPath(row: page, section: 0)
                bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func getCellCount() -> Int {
        switch self.sortLabel.text {
        case "Upload date":
            return self.recentDatas.count
        case "View count":
            return self.viewCountDatas.count
        case "Rating":
            return self.likeDatas.count
        default:
            return 0
        }
    }
    
    func fillOutCell(cell: UIContentsCollectionViewCell, indexPath: IndexPath) -> UIContentsCollectionViewCell {
        switch self.sortLabel.text {
        case "Upload date":
            cell.contentData = self.recentDatas[indexPath.item]
            break
        case "View count":
            cell.contentData = self.viewCountDatas[indexPath.item]
            break
        case "Rating":
            cell.contentData = self.likeDatas[indexPath.item]
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:  // banner
            return self.bannerDatas.count
        case 1:  // trending
            return self.trendingDatas.count
        case 2:  // recommended
            return self.recommendedDatas.count
        case 10: // super collection view
            return (self.identifierString.count - 1) + self.recentDatas.count
        case 20:
            return getCellCount()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell: UIBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! UIBannerCollectionViewCell
            
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    if let thumbnailURL = self.bannerDatas[indexPath.item].thumbnailUrl {
                        AlamoUtil.loadImage(url: thumbnailURL) { (image) in
                            cell.bannerImage.image = image
                        }
                    }
                    else if let contentsURL: String = self.bannerDatas[indexPath.item].contentsUrl {
                        AlamoUtil.loadImage(url: contentsURL) { (image) in
                            cell.bannerImage.image = image
                        }
                    }
                }
            }
            cell.titleLabel.text = self.bannerDatas[indexPath.item].contentsTitle
            return cell
        case 1:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            cell.contentData = self.trendingDatas[indexPath.item]
            return cell
        case 2:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            cell.contentData = self.recommendedDatas[indexPath.item]
            return cell
        case 10:
            let index: Int = (indexPath.item < self.identifierString.count) ? indexPath.item : self.identifierString.count - 1
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifierString[index], for: indexPath)
            if indexPath.item == 0 {
                let bannerCell: BannerViewCell = (cell as! BannerViewCell)
                self.bannerCollectionView = bannerCell.bannerCollectionView
                self.pageControl = bannerCell.pageControl
                self.bannerCollectionView.pageControl = self.pageControl
            }
            else if indexPath.item >= self.identifierString.count - 1 {
                let contentCell: UIContentsCollectionViewCell = (cell as! UIContentsCollectionViewCell)
                contentCell.contentData = self.recentDatas[indexPath.item - self.identifierString.count + 1]
            }
            return cell
        case 20:
            let cell: UIContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! UIContentsCollectionViewCell
            return fillOutCell(cell: cell, indexPath: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index: Int = indexPath.item
        
        switch collectionView.tag {
        case 0:  // banner
            self.selectedContentData = self.bannerDatas[index]
            break
        case 1:  // trending
            self.selectedContentData = self.trendingDatas[index]
            break
        case 2:  // recommended
            self.selectedContentData = self.recommendedDatas[index]
            break
        case 10: // super collection view
            if index > 4 {
                self.selectedContentData = self.recentDatas[index - 4]
            }
            else {
                self.selectedContentData = self.recentDatas[index]
            }
            break
        case 20:
            switch self.sortLabel.text {
            case "Upload date":
                self.selectedContentData = self.recentDatas[indexPath.item]
                break
            case "View count":
                self.selectedContentData = self.viewCountDatas[indexPath.item]
                break
            case "Rating":
                self.selectedContentData = self.likeDatas[indexPath.item]
                break
            default:
                break
            }
            break
        default:
            print("Unkown cell in home view controller")
            return
        }

        if let data = self.selectedContentData {
            if data.contentsType == 0 {
                self.showDetailToImageViewer()
            }
            else {
                self.showDetailToVideoPlayer()
            }

        }
    }
}
