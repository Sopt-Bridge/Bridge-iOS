//
//  UICommentTableViewCell.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UICommentTableViewCell: UITableViewCell {

    var profileImageView: UICircularImageView!
    var nameLabel: UILabel!
    var commentTextView: UITextView!
    var replayCommentLabel: UILabel!
    var deleteButton: UIButton!
    var dateLabel: UILabel!
    
    var requestData: RequestComment! {
        didSet {
            if user.userIndex != nil {
                if self.requestData.userIdx == user.userIndex { // 나중에 현재 유저로 바꾸기
                    self.deleteButton.isHidden = false
                    self.profileImageView.image = user.picture!.image
                }
                else {
                    self.deleteButton.isHidden = true
                }
            }
            
            self.nameLabel.text = self.requestData.userName
            self.commentTextView.text = self.requestData.icmtContent
            self.replayCommentLabel.text = String(self.requestData.recommentcnt!)
            
            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let changedDateFormatter = DateFormatter()
            changedDateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let date = currentDateFormatter.date(from: self.requestData.icmtDate){
                self.dateLabel.text = changedDateFormatter.string(from: date)
            }
        }
    }
    
    var commentData: ContentCommentData! {
        didSet {
            if user.userIndex != nil {
                if self.commentData.userIdx == user.userIndex { // 나중에 현재 유저로 바꾸기
                    self.deleteButton.isHidden = false
                    self.profileImageView.image = user.picture!.image
                }
                else {
                    self.deleteButton.isHidden = true
                }
            }
            
            self.nameLabel.text = self.commentData.userName
            self.commentTextView.text = self.commentData.ccmtContent
            self.replayCommentLabel.text = String(self.commentData.recommentCnt)
            
            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let changedDateFormatter = DateFormatter()
            changedDateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let date = currentDateFormatter.date(from: self.commentData.ccmtContent!){
                self.dateLabel.text = changedDateFormatter.string(from: date)
            }
        }
    }
    
    @objc func didClickedDeleteButton(_ sender: UIButton) {
        if let commentData = self.commentData {
            
            guard let index = user.userIndex else {
                return
            }
            
            ContentService.postDeleteComment(userIdx: index, ccmtIdx: commentData.ccmtIdx) {
                NotificationCenter.default.post(name: .ContentViewReloadAllTableView, object: nil)
                NotificationCenter.default.post(name: NSNotification.Name.RequestCommentViewRefresh, object: nil)
            }
        }
        else if let requestData = self.requestData {
            RequestService.postRequestCommentDelete(icmtIdx: requestData.icmtIdx!) {
                NotificationCenter.default.post(name: .RequestCommentViewRefresh, object: nil)
                NotificationCenter.default.post(name: NSNotification.Name.RequestCommentViewRefresh, object: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImageView = self.viewWithTag(-30) as! UICircularImageView
        self.nameLabel = self.viewWithTag(-31) as! UILabel
        self.deleteButton = self.viewWithTag(-32) as! UIButton
        self.commentTextView = self.viewWithTag(-33) as! UITextView
        self.dateLabel = self.viewWithTag(-34) as! UILabel
        self.replayCommentLabel = self.viewWithTag(-35) as! UILabel
        self.deleteButton.addTarget(self, action: #selector(didClickedDeleteButton), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
