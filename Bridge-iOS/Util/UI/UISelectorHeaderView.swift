//
//  UISelectorHeaderView.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 7..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class UISelectorHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var commentsLine: UIImageView!
    @IBOutlet weak var upNextLine: UIImageView!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var upNextButton: UIButton!
    
    let enableColor: UIColor = UIColor(rgb: 0xE31C9E)
    let disableColor: UIColor = UIColor.lightGray
    var callback: (() -> (Void))!
    
    @IBAction func didClickedComments(_ sender: UIButton) {
        if !self.commentsLine.isHidden {
            return
        }
        
        self.commentsButton.setTitleColor(self.enableColor, for: .normal)
        self.upNextButton.setTitleColor(self.disableColor, for: .normal)
        self.commentsLine.isHidden = false
        self.upNextLine.isHidden = true
        callback()
    }
    
    @IBAction func didClickedUpNextButton(_ sender: UIButton) {
        if !self.upNextLine.isHidden {
            return
        }
        
        self.commentsButton.setTitleColor(self.disableColor, for: .normal)
        self.upNextButton.setTitleColor(self.enableColor, for: .normal)
        self.commentsLine.isHidden = true
        self.upNextLine.isHidden = false
        callback()
    }
    
    func initCallback() {
        self.commentsButton.setTitleColor(self.enableColor, for: .normal)
        self.upNextButton.setTitleColor(self.disableColor, for: .normal)
        self.commentsLine.isHidden = false
        self.upNextLine.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        
//        NotificationCenter.default.addObserver(self, selector: #selector(initCallback), name: NSNotification.Name.ContentViewInit, object: nil)
    }
}
