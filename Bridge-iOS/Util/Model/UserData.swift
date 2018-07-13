//
//  UserData.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

struct UserServiceData: Codable {
    var message: String
    var data: [UserData]
    
    init(message: String, data: [UserData]) {
        self.message = message
        self.data = data
    }
}

struct UserData: Codable {
    var userIdx: Int
    var token: String
    
    init(userIdx: Int, token: String) {
        self.userIdx = userIdx
        self.token = token
    }
}
