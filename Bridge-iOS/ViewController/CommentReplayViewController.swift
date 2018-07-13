//
//  CommentReplayViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class CommentReplayViewController: UIViewController {

    @IBOutlet weak var replayCountLabel: UILabel!
    @IBOutlet weak var bottomInputView: UIView!
    @IBOutlet weak var commentTextField: UIRoundTextField!
    @IBOutlet weak var commentImageView: UICircularImageView!
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentTableView: UITableView!
    
    var commentData: ContentCommentData?
    var replayData: [ReplayCommentData] = []
    
    var requestCommentData: RequestComment?
    var replayRequestCommentData: [ReplayRequestComment] = []
    
    
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedEnter(_ sender: UIButton) {
        self.commentTextField.resignFirstResponder()
        self.writeReplay()
    }
    
    @objc func makeSpaceForKeyboard(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardHeight:CGFloat = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        let duration:Double = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.bottomInputView.frame
                frame.origin.y = frame.origin.y - keyboardHeight
                self.bottomInputView.frame = frame
            })
        } else {
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.bottomInputView.frame
                frame.origin.y = frame.origin.y + keyboardHeight
                self.bottomInputView.frame = frame
            })
        }
    }
    
    @objc func loadReplays() {
        if self.commentData == nil {
            if let data = self.requestCommentData {
                RequestService.getRequestReplayCommentList(icmtIdx: data.icmtIdx!, lastcontentsIdx: 0) { (datas) in
                    self.replayRequestCommentData = datas
                    if let count = data.recommentcnt {
                        self.replayCountLabel.text = String(count)
                    }
                    self.commentTableView.reloadData()
                }
            }
        }
        else if self.requestCommentData == nil {
            if let data = self.commentData {
                ContentService.getReplays(ccmtIdx: data.ccmtIdx, lastcontentsIdx: 0) { (datas) in
                    self.replayData = datas
                    self.replayCountLabel.text = String(self.replayData.count)
                    self.commentTableView.reloadData()
                }
            }
        }
    }
    
    func writeReplay() {
        
        if user.userIndex == nil {
            return
        }
        guard let text = self.commentTextField.text else {
            return
        }
        if text == "" {
            return
        }
        
        if let data = self.commentData {
            if let index = user.userIndex {
                ContentService.postReplay(ccmtIdx: data.ccmtIdx, crecmtContent: text, userIdx: index) {
                    self.loadReplays()
                    self.commentTextField.text = nil
                }
            }
        }
        else if let data = self.requestCommentData {
            if let index = user.userIndex {
                RequestService.postReplayRequestCommentWrite(icmtIdx: data.icmtIdx!, ircmtContent: text, userIdx: index) {
                    self.loadReplays()
                    self.commentTextField.text = nil
                }
            }
        }
    }
    
    func setParentComment() {
        if let data = self.commentData {
            self.commentNameLabel.text = data.userName
            self.commentTextView.text = data.ccmtContent
            self.replayCountLabel.text = String(data.recommentCnt)//String(self.replayData.count)
            
            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let changedDateFormatter = DateFormatter()
            changedDateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let date = currentDateFormatter.date(from: data.ccmtDate!){
                self.commentDateLabel.text = changedDateFormatter.string(from: date)
            }
            
            if let index = user.userIndex {
                if index == data.userIdx {
                    self.commentImageView.image = user.picture!.image
                }
            }
        }
        else if let data = self.requestCommentData {
            self.commentNameLabel.text = data.userName
            self.commentTextView.text = data.icmtContent
            self.replayCountLabel.text = String(data.recommentcnt!)
            
            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let changedDateFormatter = DateFormatter()
            changedDateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let date = currentDateFormatter.date(from: data.icmtDate){
                self.commentDateLabel.text = changedDateFormatter.string(from: date)
            }
            
            if let index = user.userIndex {
                if index == data.userIdx {
                    self.commentImageView.image = user.picture!.image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setParentComment()
        
        self.loadReplays()
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadReplays), name: NSNotification.Name.ReplayCommentReloadAllTableView, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CommentReplayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.commentData == nil {
            return self.replayRequestCommentData.count
        }
        return self.replayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UIReplayCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentReplayCell", for: indexPath) as! UIReplayCommentTableViewCell
        if self.commentData == nil {
            cell.requestData = self.replayRequestCommentData[indexPath.item]
            return cell
        }
        cell.commentData = self.replayData[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CommentReplayViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.writeReplay()
        return true
    }
}
