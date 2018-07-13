//
//  SubscribeViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 4..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {

    @IBOutlet weak var sortLabel: UILabel!
    
    let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
    
    func initActionSheet() {
        let uploadDateAction: UIAlertAction = UIAlertAction(title: "Upload date", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "Upload date"
        })
        
        let viewCountAction: UIAlertAction = UIAlertAction(title: "View count", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "View count"
        })
        
        let ratingAction: UIAlertAction = UIAlertAction(title: "Rating", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.sortLabel.text = "Rating"
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        uploadDateAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        viewCountAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        ratingAction.setValue(UIColor(rgb: 0x8E8E93), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: 0xE31C9E), forKey: "titleTextColor")
        
        self.actionSheet.addAction(uploadDateAction)
        self.actionSheet.addAction(viewCountAction)
        self.actionSheet.addAction(ratingAction)
        self.actionSheet.addAction(cancelAction)
    }
    
    @IBAction func didClickedSortButton(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initActionSheet()
        self.present(prepareAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SubscribeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //FollowCell
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath)
        return cell
    }
}
