//
//  UIContentsCollectionViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 2..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIContentsCollectionViewCell: UICollectionViewCell {
    
    var thumbnailImageView: UIImageView!
    var contentsTypeImageView: UIImageView!
    var contentsNameLabel: UILabel!
    var thumbnailImage: UIImage? = nil
    
    var contentData: ContentData! {
        didSet {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    if let thumbnailURL = self.contentData.thumbnailUrl {
                        AlamoUtil.loadImage(url: thumbnailURL) { (image) in
                            self.thumbnailImage = image
                            self.thumbnailImageView.image = self.thumbnailImage
                        }
                    }
                    else if let contentURL = self.contentData.contentsUrl {
                        AlamoUtil.loadImage(url: contentURL) { (image) in
                            self.thumbnailImage = image
                            self.thumbnailImageView.image = self.thumbnailImage
                        }
                    }
                }
            }
            if self.contentData.contentsType == 0 {
                self.contentsTypeImageView.image = #imageLiteral(resourceName: "home_image_thumnail_icon")
            }
            else {
                self.contentsTypeImageView.image = #imageLiteral(resourceName: "home_video_thumnail_icon")
            }
            self.contentsNameLabel.text = self.contentData.contentsTitle
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if let thumbnailURL = self.contentData.thumbnailUrl {
                    AlamoUtil.loadImage(url: thumbnailURL) { (image) in
                        self.thumbnailImage = image
                        self.thumbnailImageView.image = self.thumbnailImage
                    }
                }
                else if let contentURL = self.contentData.contentsUrl {
                    AlamoUtil.loadImage(url: contentURL) { (image) in
                        self.thumbnailImage = image
                        self.thumbnailImageView.image = self.thumbnailImage
                    }
                }
            }
        }
        if self.contentData.contentsType == 0 {
            self.contentsTypeImageView.image = #imageLiteral(resourceName: "home_image_thumnail_icon")
        }
        else {
            self.contentsTypeImageView.image = #imageLiteral(resourceName: "home_video_thumnail_icon")
        }
        self.contentsNameLabel.text = self.contentData.contentsTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.thumbnailImageView = self.viewWithTag(50) as! UIImageView
        self.contentsTypeImageView = self.viewWithTag(51) as! UIImageView
        self.contentsNameLabel = self.viewWithTag(52) as! UILabel
    }
}
