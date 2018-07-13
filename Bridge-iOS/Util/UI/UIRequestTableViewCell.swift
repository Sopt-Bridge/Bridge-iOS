//
//  UIRequestTableViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIRequestTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var nameLabel: UILabel!
    var dateLabel: UILabel!
    
    var requestData: RequestData? {
        didSet {
            if let data = self.requestData {
                if let titleLabel = self.titleLabel {
                    titleLabel.text = data.iboardTitle
                }
                if let nameLabel = self.nameLabel {
                    nameLabel.text = data.userName
                }
                if let dateLabel = self.dateLabel {
                    dateLabel.text = data.iboardDate
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let titleLabel = self.viewWithTag(99) as? UILabel {
            self.titleLabel = titleLabel
        }
        if let nameLabel = self.viewWithTag(98) as? UILabel {
            self.nameLabel = nameLabel
        }
        if let dateLabel = self.viewWithTag(97) as? UILabel {
            self.dateLabel = dateLabel
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
