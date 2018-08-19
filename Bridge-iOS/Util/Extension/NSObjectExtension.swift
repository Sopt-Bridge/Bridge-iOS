//
//  NSObjectExtension.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 8. 17..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

extension NSObject {

    static var distinctIdentifier: String {
        return String(describing: self)
    }

    var distinctIdentifier: String {
        return String(describing: self)
    }
}
