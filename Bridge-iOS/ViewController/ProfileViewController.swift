//
//  ProfileViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UICircularImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
    
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedSettingButton(_ sender: UIButton) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func initActionSheet() {
        let logoutAction: UIAlertAction = UIAlertAction(title: "로그아웃", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        let removeAcountAction: UIAlertAction = UIAlertAction(title: "회원탈퇴", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        logoutAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        removeAcountAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: 0xE31C9E), forKey: "titleTextColor")
        
        self.actionSheet.addAction(logoutAction)
        self.actionSheet.addAction(removeAcountAction)
        self.actionSheet.addAction(cancelAction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initActionSheet()
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension ProfileViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
