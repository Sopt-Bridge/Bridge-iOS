//
//  RequestData.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

struct RequestServiceData: Codable {
    var message: String
    var data: [RequestDataList]
}

struct RequestDataList: Codable {
    var request_list: [RequestData]?
    var request_comment_list: [RequestComment]?
    var request_recomment_list: [ReplayRequestComment]?
    var recommentCnt: Int?
}

struct ReplayRequestComment: Codable {
    var ircmtDate: String
    var ircmtContent: String
    var userIdx: Int
    var userName: String?
    var ircmtIdx: Int?
}

struct RequestComment: Codable {
    var icmtDate: String
    var icmtContent: String
    var userIdx: Int
    var icmtIdx: Int?
    var userName: String?
    var recommentcnt: Int?
}

struct RequestData: Codable {
    var iboardIdx: Int
    var iboardUrl: String?
    var iboardContent: String
    var iboardTitle: String
    var iboardDate: String?
    var userIdx: Int
    var userName: String?
}
