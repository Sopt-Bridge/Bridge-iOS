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
    @IBOutlet weak var myRequestsTableView: UITableView!
    
    let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
    
    var myRequests: [RequestData] = []
    
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedSettingButton(_ sender: UIButton) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func initActionSheet() {
        let logoutAction: UIAlertAction = UIAlertAction(title: "Logout", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            user.token = nil
            user.userIndex = nil
            NotificationCenter.default.post(name: .RefreshNavigationItem, object: nil)
            self.dismiss(animated: true, completion: nil)
        })
        
        let removeAcountAction: UIAlertAction = UIAlertAction(title: "Remove this Account", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            self.present(removeAcountAlert, animated: true, completion: nil)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        logoutAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        removeAcountAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: 0xE31C9E), forKey: "titleTextColor")
        
        self.actionSheet.addAction(logoutAction)
        self.actionSheet.addAction(removeAcountAction)
        self.actionSheet.addAction(cancelAction)
    }
    
    func loadMyRequests() {
        
        guard let index = user.userIndex else {
            return
        }
        
        LoginService.getMyRequests(userIdx: index) { (datas) in
            self.myRequests = datas
            self.myRequestsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initActionSheet()
        self.loadMyRequests()
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        if let image = user.picture?.image {
            self.profileImageView.image = image
        }
        if let name = user.fullName {
            self.nameLabel.text = name
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UIRequestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyWritingCell") as! UIRequestTableViewCell
        cell.requestData = self.myRequests[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailInterpretationViewController") as? DetailInterpretationViewController
        {
            vc.requestData = self.myRequests[indexPath.item]
            self.showDetailViewController(vc, sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
