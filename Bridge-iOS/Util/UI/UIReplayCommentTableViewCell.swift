//
//  UIReplayCommentTableViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UIReplayCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentImageView: UICircularImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentDateLabel: UILabel!
    
    var commentData: ReplayCommentData? {
        didSet {
            if let data = self.commentData {
                if user.userIndex == data.userIdx {
                    self.deleteButton.isHidden = false
                    self.commentImageView.image = user.picture!.image
                }
                else {
                    self.deleteButton.isHidden = true
                }
                self.nameLabel.text = data.userName
                self.commentTextView.text = data.crecmtContent
//                self.replayCommentLabel.text = String(self.commentData.recommentCnt)
                
                let currentDateFormatter = DateFormatter()
                currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let changedDateFormatter = DateFormatter()
                changedDateFormatter.dateFormat = "MM/dd/yyyy"
                
                if let date = currentDateFormatter.date(from: data.crecmtDate){
                    self.commentDateLabel.text = changedDateFormatter.string(from: date)
                }
            }
        }
    }
    
    var requestData: ReplayRequestComment? {
        didSet {
            if let data = self.requestData {
                if user.userIndex == data.userIdx {
                    self.deleteButton.isHidden = false
                    self.commentImageView.image = user.picture!.image
                }
                else {
                    self.deleteButton.isHidden = true
                }
                self.nameLabel.text = data.userName
                self.commentTextView.text = data.ircmtContent
                
                let currentDateFormatter = DateFormatter()
                currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let changedDateFormatter = DateFormatter()
                changedDateFormatter.dateFormat = "MM/dd/yyyy"
                
                if let date = currentDateFormatter.date(from: data.ircmtDate){
                    self.commentDateLabel.text = changedDateFormatter.string(from: date)
                }
            }
        }
    }
    
    @IBAction func didClickedDeleteButton(_ sender: UIButton) {
        
        guard let index = user.userIndex else {
            return
        }
        
        if let data = self.commentData {
            ContentService.postDeleteReplay(crecmtIdx: data.crecmtIdx, userIdx: index) {
                NotificationCenter.default.post(name: .ReplayCommentReloadAllTableView, object: nil)
            }
        }
        else if let data = self.requestData {
            //서버가 인덱스 줘야함
            RequestService.postReplayRequestCommentDelete(ircmtIdx: data.ircmtIdx!) {
                NotificationCenter.default.post(name: .ReplayCommentReloadAllTableView, object: nil)
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
