//
//  ContentsViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 1..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import WebKit
import AVKit
import AVFoundation

class ContentsViewController: UIViewController {
    
    @IBOutlet weak var youtubeWebView: WKWebView!
    @IBOutlet weak var streamingView: UIStreamingView!
    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var bottomInputView: UIView!
    @IBOutlet weak var commentTextField: UIRoundTextField!
    @IBOutlet weak var contentTitleLabel: UITextView!
    @IBOutlet weak var contentCreditLabel: UILabel!
    @IBOutlet weak var contentHashTagLabel: UILabel!
    @IBOutlet weak var libraryToggleButton: UIToggleButton!
    @IBOutlet weak var feedbackToggleButton: UIToggleButton!
    @IBOutlet weak var likeToggleButton: UIToggleButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    var isCommentTableView: Bool = true
    var contentData: ContentData?
    var commentDatas: [ContentCommentData] = []
    var upNextDatas: [ContentData] = []
    var selectorHeader: UISelectorHeaderView!
    
    @IBAction func didClickedEnter(_ sender: UIButton) {
        self.commentTextField.resignFirstResponder()
        self.registerComment()
    }
    
    @IBAction func didClickedPlayButton(_ sender: UIButton) {
        self.streamingView.playeVideoToAVPlayer(viewController: self)
    }
    
    @IBAction func didClickedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
    }
    
    func openVideoToYoutube(url: String) {
        print("youtube")
        self.streamingView.isHidden = true
        self.youtubeWebView.isHidden = false
        let urlData: URL = URL(string: url)!
        let myURLRequest: URLRequest = URLRequest(url: urlData)
        self.youtubeWebView.load(myURLRequest)
        self.youtubeWebView.scrollView.isScrollEnabled = false
    }
    
    func openVideoToAVPlayer() {
        print("av player")
        self.streamingView.isHidden = false
        self.youtubeWebView.isHidden = true
    }
    
    func setVideoPlayer() {
        if let url = self.contentData?.contentsUrl {
            if url.contains("youtube") {
                self.openVideoToYoutube(url: url)
            }
            else {
                self.streamingView.initAVKit(url: url)
                self.openVideoToAVPlayer()
            }
        }
    }
    
    @objc func loadComment() {
        if let data: ContentData = self.contentData {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    ContentService.getContentComment(contentIndex: data.contentsIdx, lastContentsIndex: 0) { (datas) in
                        self.commentDatas = datas
                        self.bottomTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func loadUpNextVideos() {
        if let data: ContentData = self.contentData {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    let group: DispatchGroup = DispatchGroup()
            
                    group.enter()
                    ContentService.getUpNext(lastContentsIdx: 0, contentsIdx: data.contentsIdx) { (datas) in
                        self.upNextDatas = datas
                        group.leave()
                    }
            
                    group.notify(queue: .main) {
                        self.bottomTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func refreshData(contentData: ContentData?) {
        if let data = contentData {
            if let userIndex = user.userIndex {
                ContentService.postContent(userIdx: userIndex, contentsIdx: data.contentsIdx, contentsType: data.contentsType!) { (data) in
                    self.setView()
                }
            }
        }
    }
    
    func setView() {
        if let data = self.contentData {
            self.contentTitleLabel.text = data.contentsTitle
            self.contentCreditLabel.text = data.contentsoriginUrl
            self.contentHashTagLabel.text = data.getHashTag()
            self.likeLabel.text = String(data.contentsLike)
            
            if user.userIndex != nil {
                ContentService.postContent(userIdx: user.userIndex!, contentsIdx: data.contentsIdx, contentsType: data.contentsType!) { (loadedData) in
                    print("sub: \(loadedData.subFlag), like: \(loadedData.likeFlag)")
                    if let subFlag: Int = loadedData.subFlag {
                        self.libraryToggleButton.setDefaultState(isOn: subFlag == 1 ? true : false)
                    }
                    
                    if let likeFlag: Int = loadedData.likeFlag {
                        self.likeToggleButton.setDefaultState(isOn: likeFlag == 1 ? true : false)
                    }
                }
            }
            
            self.libraryToggleButton.toggleOnCallback = {
                self.present(prepareAlert, animated: true, completion: nil)
            }
            
            self.libraryToggleButton.toggleOffCallback = {}
            
            self.feedbackToggleButton.toggleOnCallback = {
                self.present(prepareAlert, animated: true, completion: nil)
            }
            
            self.feedbackToggleButton.toggleOffCallback = {}
            
            self.likeToggleButton.toggleOnCallback = {
                print("on")
                if let index = user.userIndex {
                    ContentService.postLike(contentsIdx: data.contentsIdx, userIdx: index, completion: {
                        
                    })
                }
            }
            
            self.likeToggleButton.toggleOffCallback = {
                print("off")
                if let index = user.userIndex {
                    ContentService.postLike(contentsIdx: data.contentsIdx, userIdx: index, completion: {
                        
                    })
                }
            }
            
            ContentService.postAddViewCount(contentsIdx: data.contentsIdx)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setVideoPlayer()
        self.loadComment()
        self.setView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadComment), name: NSNotification.Name.ContentViewReloadAllTableView, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ContentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isCommentTableView {
            return self.commentDatas.count
        }
        return self.upNextDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isCommentTableView {
            let cell: UICommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! UICommentTableViewCell
            cell.commentData = self.commentDatas[indexPath.item]
            return cell
        }
        let cell: UIUpNextTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UpNextCell", for: indexPath) as! UIUpNextTableViewCell
        cell.contentData = self.upNextDatas[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "TableViewSectionHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "Header")
        self.selectorHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! UISelectorHeaderView
        self.selectorHeader.callback = {
            self.isCommentTableView = !self.isCommentTableView
            
            if self.isCommentTableView {
                self.loadComment()
            }
            else {
                self.loadUpNextVideos()
            }
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.bottomTableView.reloadData()
                }
            }
        }
        return self.selectorHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isCommentTableView {
            return 165
        }
        return 129
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.isCommentTableView {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.contentData = self.upNextDatas[indexPath.item]
                    self.setVideoPlayer()
                    self.setView()
                    self.isCommentTableView = true
                    self.selectorHeader.initCallback()
                    self.bottomTableView.reloadData()
                    tableView.setContentOffset(.zero, animated: true)
                }
            }
        }
        else {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentReplayViewController") as? CommentReplayViewController
            {
                vc.commentData = (tableView.cellForRow(at: indexPath) as! UICommentTableViewCell).commentData
                self.showDetailViewController(vc, sender: nil)
            }
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}

extension ContentsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.registerComment()
        return true
    }
}
