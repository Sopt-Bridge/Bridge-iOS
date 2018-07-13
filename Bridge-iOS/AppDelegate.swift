//
//  AppDelegate.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 6. 30..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "954295210987-hu1hcnqhjku2qvnqk62iqoi2dssu6ah6.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor googleUser: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("----- error -----")
            print("\(error.localizedDescription)")
        }
        else {
//            let idToken = googleUser.authentication.idToken
            let url = googleUser.profile.imageURL(withDimension: 100).absoluteString
            user.firstName = googleUser.profile.familyName
            user.lastName = googleUser.profile.givenName
            user.fullName = googleUser.profile.name
            
            if let id = Int64(googleUser.userID) {
                print(id)
            }
            else {
                print("casting Error: \(googleUser.userID)")
            }
            
            let group = DispatchGroup()
            group.enter()
            LoginService.postLogin(userUuid: googleUser.userID, userName: googleUser.profile.name, completion: { (data) in
                
                user.userIndex = data.userIdx
                user.token = data.token
                AlamoUtil.loadImage(url: url, completion: { (image) in
                    user.picture = Profile(frame: CGRect(x: 0, y: 0, width: 84, height: 84), transform: CGAffineTransform.identity, imagetoData: image!)
                    group.leave()
                })

                group.notify(queue: .main) {
                    saveUserData()
                }
                
                NotificationCenter.default.post(name: .RefreshNavigationItem, object: nil)
            })
        }
    }
}
