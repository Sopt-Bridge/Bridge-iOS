//
//  User.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 8..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit
import Cache

struct Profile: Codable {
    
    let frame: CGRect
    let transform: CGAffineTransform
    
    var imageData: Data = Data()
    var image: UIImage {
        set { self.imageData = try! JSONEncoder().encode(ImageWrapper(image: newValue)) }
        get { return try! JSONDecoder().decode(ImageWrapper.self, from: self.imageData).image }
    }
    
    init(frame: CGRect, transform: CGAffineTransform, imagetoData: UIImage) {
        self.frame = frame
        self.transform = transform
        
        image = imagetoData
    }
}

struct User: Codable {
    
    var fullName: String?
    var firstName: String?
    var lastName: String?
    var pictureAddress: String?
    var picture: Profile?
    var token: String?
    var userIndex: Int?
    
    init(fullName: String?, firstName: String?, lastName: String?, email: String?, pictureAddress: String?, token: String?, userIndex: Int?) {
        self.fullName = fullName
        self.firstName = firstName
        self.lastName = lastName
        self.pictureAddress = pictureAddress
        self.picture = nil
        self.token = token
        self.userIndex = userIndex
    }
    
    static func userDataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let todosURL: URL
        
        documentURL = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory,
                                          in: FileManager.SearchPathDomainMask.userDomainMask,
                                          appropriateFor: nil, create: false)
        todosURL = documentURL.appendingPathComponent("user.plist")
        return todosURL
    }
}

var user: User = {
    do {
        let data: Data = try Data(contentsOf: User.userDataURL())
        let decoder: PropertyListDecoder = PropertyListDecoder()
        let user: User?
        user = try? decoder.decode(User.self, from: data)
        return user ?? User(fullName: nil, firstName: nil, lastName: nil, email: nil, pictureAddress: nil, token: nil, userIndex: nil)
    }
    catch {
        print("Decode user date error: \(error.localizedDescription)")
    }
    
    return User(fullName: nil, firstName: nil, lastName: nil, email: nil, pictureAddress: nil, token: nil, userIndex: nil)
}()

func saveUserData() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(user)
        try data.write(to: User.userDataURL())
    } catch {
        print("Encode user data error: \(error.localizedDescription)")
    }
}
