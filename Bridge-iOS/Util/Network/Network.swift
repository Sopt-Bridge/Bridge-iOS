//
//  Network.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 8..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire

protocol Network {
    
}

extension Network {
    
    static func url(path: String, parameters: Any?...) -> String {
        
        var result: String = ""
        parameters.forEach { (param) in
            result.append("/")
            if let value = param as? String {
                result.append(contentsOf: value)
            }
            else if let value = param as? Int {
                result.append(contentsOf: String(value))
            }
        }
        return "http://13.124.201.59\(path)\(result)"
    }
}
