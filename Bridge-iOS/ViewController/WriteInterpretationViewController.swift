//
//  WriteInterpretationViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 5..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class WriteInterpretationViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var linkLabel: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func didClickedBackButton(_ sender: UIBarButtonItem) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @IBAction func didClicekdDoneButton(_ sender: UIBarButtonItem) {
        writeRequest()
    }
    
    @objc func endEdit(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func writeRequest() {
        if let index = user.userIndex {
            if !self.linkLabel.text!.isEmpty && !self.titleLabel.text!.isEmpty && !self.contentTextView.text!.isEmpty {
                RequestService.postWrite(userIdx: index, iboardUrl: self.linkLabel.text!, iboardContent: self.contentTextView.text!, iboardTitle: self.titleLabel.text!) {
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        
        self.userNameLabel.text = user.fullName
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.dateLabel.text = formatter.string(from: date)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (endEdit))
        self.view.addGestureRecognizer(gesture)
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

extension WriteInterpretationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension WriteInterpretationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
}
