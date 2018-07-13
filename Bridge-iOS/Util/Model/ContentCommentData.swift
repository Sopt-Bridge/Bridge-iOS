//
//  ContentCommentModel.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

class ContentCommentServiceData: Codable {
    var message: String
    var data: [ContentCommentList]
    
    init(message: String, data: [ContentCommentList]) {
        self.message = message
        self.data = data
    }
}

class ContentCommentList: Codable {
    var comments_list: [ContentCommentData]?
    var recomment_list: [ReplayCommentData]?
    
    init(comments_list: [ContentCommentData]?, recomment_list: [ReplayCommentData]?) {
        self.comments_list = comments_list
        self.recomment_list = recomment_list
    }
}

class ReplayCommentData: Codable {
    var crecmtDate: String
    var crecmtContent: String
    var userIdx: Int
    var userName: String
    var recommentCnt: Int
    var crecmtIdx: Int
    
    init(crecmtDate: String, crecmtContent: String, userIdx: Int, userName: String, recommentCnt: Int, crecmtIdx: Int) {
        self.crecmtDate = crecmtDate
        self.crecmtContent = crecmtContent
        self.userIdx = userIdx
        self.userName = userName
        self.recommentCnt = recommentCnt
        self.crecmtIdx = crecmtIdx
    }
}

class ContentCommentData: Codable {
    var ccmtDate: String?
    var ccmtContent: String?
    var ccmtIdx: Int
    var userIdx: Int
    var userName: String
    var recommentCnt: Int
    
    init(ccmtDate: String?, ccmtContent: String?, ccmtIdx: Int, userIdx: Int, userName: String, recommentCnt: Int) {
        self.ccmtDate = ccmtDate
        self.ccmtContent = ccmtContent
        self.ccmtIdx = ccmtIdx
        self.userIdx = userIdx
        self.userName = userName
        self.recommentCnt = recommentCnt
    }
}
