//
//  ImageContentsViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 8..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class ImageContentsViewController: UIViewController {

    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imageInfo: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeToggleButton: UIToggleButton!
    @IBOutlet weak var libraryToggleButton: UIToggleButton!
    @IBOutlet weak var feedBackToggleButton: UIToggleButton!
    
    var contenData: ContentData?
    var imageDatas: [UIImage] = []
    
    @IBAction func didClickedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setView() {
        if let data = self.contenData {
            self.imageCountLabel.text = "1/\(data.imgCnt!)"
            self.imageInfo.text = data.contentsInfo
            self.likeCountLabel.text = String(data.contentsLike)

            if let index = user.userIndex {
                ContentService.postContentImage(userIdx: index, contentsIdx: data.contentsIdx, contentsType: 0) { (datas) in
                    
                    self.contenData = datas[0]
//                    print("sub: \(datas[0].subFlag), like: \(datas[0].likeFlag)")
                    
                    if let subFlag: Int = datas[0].subFlag {
                        self.libraryToggleButton.setDefaultState(isOn: subFlag == 1 ? true : false)
                    }
                        
                    if let likeFlag: Int = datas[0].likeFlag {
                        self.likeToggleButton.setDefaultState(isOn: likeFlag == 1 ? true : false)
                    }
                    
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            datas.forEach({ (data) in
                                if let url = data.contentsUrl {
                                    AlamoUtil.loadImage(url: url, completion: { (image) in
                                        self.imageDatas.append(image!)
                                        self.imageCollectionView.reloadData()
                                    })
                                }
                            })
                        }
                    }
                }
            }
            
            self.likeToggleButton.toggleOnCallback = {
                if let index = user.userIndex {
                    print("on")
                    ContentService.postLike(contentsIdx: data.contentsIdx, userIdx: index, completion: {})
                }
            }
            self.likeToggleButton.toggleOffCallback = {
                if let index = user.userIndex {
                    print("off")
                    ContentService.postLike(contentsIdx: data.contentsIdx, userIdx: index, completion: {})
                }
            }
            
            self.libraryToggleButton.toggleOnCallback = {
                self.present(prepareAlert, animated: true, completion: nil)
            }
            self.libraryToggleButton.toggleOffCallback = {
                
            }
            
            self.feedBackToggleButton.toggleOnCallback = {
                self.present(prepareAlert, animated: true, completion: nil)
            }
            self.feedBackToggleButton.toggleOffCallback = {
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let commentView = segue.destination as? CommentsViewController {
            commentView.contentData = self.contenData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ImageContentsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width) + 1
        if let imgCnt = self.contenData?.imgCnt {
            self.imageCountLabel.text = "\(page)/\(imgCnt)"
        }
    }
}

extension ImageContentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UIImageContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! UIImageContentCollectionViewCell
        cell.imageView.image = self.imageDatas[indexPath.item]
        return cell
    }
}
