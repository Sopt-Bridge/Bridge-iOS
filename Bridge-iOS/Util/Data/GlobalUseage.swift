//
//  GlobalUseage.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 8..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import UIKit

func getDate(currentDate: String) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //2018-07-07 05:21:50
    
    let returnDateFormatter = DateFormatter()
    returnDateFormatter.dateFormat = "MMM/dd/yyyy"
    
    if let date = dateFormatter.date(from: currentDate){
        return returnDateFormatter.string(from: date)
    }
    
    return ""
}

let signUpAlert: UIAlertController = {
    let alert: UIAlertController = UIAlertController(title: "Sign up", message: "Then, you can use this function.", preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
        (action: UIAlertAction!) -> Void in
    })
    
    alert.addAction(okAction)
    return alert
}()

let removeAcountAlert: UIAlertController = {
    let alert: UIAlertController = UIAlertController(title: "Remove this account", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler:{
        (action: UIAlertAction!) -> Void in
        
        guard let token = user.token else {
            return
        }
        
        LoginService.postQuitAccount(token: token, completion: {
            user.token = nil
            user.userIndex = nil
            NotificationCenter.default.post(name: .RefreshNavigationItem, object: nil)
            saveUserData()
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                    topController.dismiss(animated: true, completion: nil)
                }
            }
        })
    })
    
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
        (action: UIAlertAction!) -> Void in
    })
    
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    return alert
}()

let prepareAlert: UIAlertController = {
    let alert: UIAlertController = UIAlertController(title: "Sorry!", message: "Now preparing", preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
        (action: UIAlertAction!) -> Void in
        
    })
    
    alert.addAction(okAction)
    return alert
}()
