//
//  CommentsViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 7..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UIRoundTextField!
    @IBOutlet weak var enterButton: UIRoundButton!
    @IBOutlet weak var bottomInputView: UIView!
    
    var contentData: ContentData? = nil
    var requestData: RequestData? = nil
    var commentData: [ContentCommentData] = []
    var requestCommentData: [RequestComment] = []
    var isKeyboardOpen: Bool = false
    
    @IBAction func didClickedCommentsButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedEnter(_ sender: UIButton) {
        self.registerComment()
    }
    
    @objc func makeSpaceForKeyboard(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardHeight:CGFloat = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        let duration:Double = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            if self.isKeyboardOpen {
                return
            }
            self.isKeyboardOpen = true
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.bottomInputView.frame
                frame.origin.y = frame.origin.y - keyboardHeight
                self.bottomInputView.frame = frame
            })
        } else {
            self.isKeyboardOpen = false
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.bottomInputView.frame
                frame.origin.y = frame.origin.y + keyboardHeight
                self.bottomInputView.frame = frame
            })
        }
    }
    
    func registerComment() {
        if let data: ContentData = self.contentData {
            if let comment: String = self.commentTextField.text {
                if let index = user.userIndex {
                    ContentService.postComment(contentsIdx: data.contentsIdx, ccmtContent: comment, userIdx: index) {
                        self.loadComment()
                    }
                    self.commentTextField.text = nil
                }
            }
        }
        else if let data: RequestData = self.requestData {
            if let comment: String = self.commentTextField.text {
                if let index: Int = user.userIndex {
                    RequestService.postCommentWrite(userIdx: index, icmtContent: comment, iboardIdx: data.iboardIdx) {
                        self.loadComment()
                    }
                    self.commentTextField.text = nil
                }
            }
        }
    }
    
    func loadContentComments() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if let data = self.contentData {
                    ContentService.getContentComment(contentIndex: data.contentsIdx, lastContentsIndex: 0, completion: { (datas) in
                        self.commentData = datas
                        self.commentTableView.reloadData()
                    })
                }
            }
        }
    }
    
    func loadRequestComments() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if let data = self.requestData {
                    RequestService.getRequestCommentList(iboardIdx: data.iboardIdx, lastcontentsIdx: 0, completion: { (datas) in
                        self.requestCommentData = datas
                        self.commentTableView.reloadData()
                    })
                }
            }
        }
    }
    
    @objc func loadComment() {
        if self.contentData != nil {
            self.loadContentComments()
        }
        else if self.requestData != nil {
            print("requestdata: \(self.requestData?.iboardIdx)")
            self.loadRequestComments()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadComment()
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadComment), name: NSNotification.Name.RequestCommentViewRefresh, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.contentData == nil {
            return self.requestCommentData.count
        }
        return self.commentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UICommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! UICommentTableViewCell
        if self.contentData == nil {
            cell.requestData = self.requestCommentData[indexPath.item]
            return cell
        }
        cell.commentData = self.commentData[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentReplayViewController") as? CommentReplayViewController
        {
            if self.contentData == nil {
                vc.requestCommentData = (tableView.cellForRow(at: indexPath) as! UICommentTableViewCell).requestData
            }
            else {
                vc.commentData = (tableView.cellForRow(at: indexPath) as! UICommentTableViewCell).commentData
            }
            self.showDetailViewController(vc, sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension CommentsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.registerComment()
        return true
    }
}
