//
//  ContentData.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 9..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

struct ContentData: Codable {
    var contentsIdx: Int
    var contentsUrl: String?
    var contentsoriginUrl: String?
    var contentsCategory: Int
    var imgCnt: Int?
    var commentCnt: Int
    var contentsDate: String?
    var contentsHit: Int?
    var contentsInfo: String?
    var contentsLike: Int
    var contentsRuntime: String?
    var contentsTitle: String
    var contentsType: Int?
    var hashName1: String?
    var hashName2: String?
    var hashName3: String?
    var likeFlag: Int?
    var subFlag: Int?
    var thumbnailUrl: String?
    var imgname: String?
    
    init(contentsDate: String?, contentsHit: Int?, contentsInfo: String?, contentsLike: Int, contentsRuntime: String?, contentsTitle: String, contentsType: Int?, hashName1: String?, hashName2: String?, hashName3: String?, contentsIdx: Int, contentsUrl: String?, contentsoriginUrl: String?, imgCnt: Int?, commentCnt: Int, contentsCategory: Int, likeFlag: Int?, subFlag: Int?, thumbnailUrl: String?, imgname: String?) {
        self.contentsIdx = contentsIdx
        self.contentsUrl = contentsUrl
        self.contentsoriginUrl = contentsoriginUrl
        self.imgCnt = imgCnt
        self.commentCnt = commentCnt
        self.contentsDate = contentsDate
        self.contentsHit = contentsHit
        self.contentsInfo = contentsInfo
        self.contentsLike = contentsLike
        self.contentsRuntime = contentsRuntime
        self.contentsTitle = contentsTitle
        self.contentsType = contentsType
        self.hashName1 = hashName1
        self.hashName2 = hashName2
        self.hashName3 = hashName3
        self.contentsCategory = contentsCategory
        self.likeFlag = likeFlag
        self.subFlag = subFlag
        self.thumbnailUrl = thumbnailUrl
        self.imgname = imgname
    }
    
    func getHashTag() -> String {
        var returnValue: String = ""
        if let hashtag = self.hashName1 {
            returnValue += " \(hashtag)"
        }
        if let hashtag2 = self.hashName2 {
            returnValue += " \(hashtag2)"
        }
        if let hashtag3 = self.hashName3 {
            returnValue += " \(hashtag3)"
        }
        return returnValue
    }
}

