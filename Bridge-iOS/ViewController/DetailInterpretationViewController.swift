//
//  DetailInterpretationViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 7..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class DetailInterpretationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var textLabel: UITextView!
    
    var requestData: RequestData?
    
    @IBAction func didClickedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setView() {
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let changedDateFormatter = DateFormatter()
        changedDateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let data = self.requestData {
            self.titleLabel.text = data.iboardTitle
            self.nameLabel.text = data.userName
            self.linkLabel.text = data.iboardUrl
            self.textLabel.text = data.iboardContent
            self.dateLabel.text = data.iboardDate
//            if let date = currentDateFormatter.date(from: data.iboardDate!){
//                self.dateLabel.text = changedDateFormatter.string(from: date)
//            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let commentView = segue.destination as? CommentsViewController {
            commentView.requestData = self.requestData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        print(self.requestData?.iboardIdx)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
