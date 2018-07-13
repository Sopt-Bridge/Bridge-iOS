//
//  UIUpNextTableViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIUpNextTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var hashTagLabel: UITextView!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    var contentData: ContentData? {
        didSet {
            if let data = self.contentData {
                self.titleLabel.text = data.contentsTitle
                self.hashTagLabel.text = data.getHashTag()
                self.playTimeLabel.text = data.contentsRuntime
                
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        if let thumbnailURL = data.thumbnailUrl {
                            AlamoUtil.loadImage(url: thumbnailURL, completion: { (image) in
                                self.thumbnailImageView.image = image
                            })
                        }
                        else if let contentsURL = data.contentsUrl {
                            AlamoUtil.loadImage(url: contentsURL, completion: { (image) in
                                self.thumbnailImageView.image = image
                            })
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
