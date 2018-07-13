//
//  HomeServiceData.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 8..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

struct HomeServiceData: Codable {
    var data: [ContentDatas]
    var message: String
    
    init(data: [ContentDatas], message: String) {
        self.data = data
        self.message = message
    }
}

struct ContentDatas: Codable {
    var contents_list: [ContentData]
    
//    enum CodingKeys: String, CodingKey {
//        case contentsList = "contents_list"
//    }
    
    init(contents_list: [ContentData]) {
        self.contents_list = contents_list
    }
}
