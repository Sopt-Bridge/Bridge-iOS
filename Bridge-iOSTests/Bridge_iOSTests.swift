//
//  Bridge_iOSTests.swift
//  Bridge-iOSTests
//
//  Created by 김덕원 on 2018. 7. 2..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import XCTest

class Bridge_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoop() {
        var stringList: [String] = ["A", "B", "C", "D", "E"]
        for i in 0 ..< stringList.count {
            let index: Int = (i + 1) % stringList.count
            print(stringList[index])
        }
    }
    
    func testCustomAscendingListSort() {
        var stringList: [String] = ["A", "B", "C", "D"]
        
        print("Befor sort: \(stringList)")
        for i in stride(from: stringList.count, to: 1, by: -1) {
            let index: Int = i % (stringList.count)
            (stringList[i - 1], stringList[index]) = (stringList[index], stringList[i - 1])
            print("Count: \(i), List: \(stringList)")
        }
        print("After sort: \(stringList)")
        XCTAssert(stringList == ["D", "A", "B", "C"])
        
        for i in stride(from: stringList.count, to: 1, by: -1) {
            let index: Int = i % (stringList.count)
            (stringList[i - 1], stringList[index]) = (stringList[index], stringList[i - 1])
            print("Count: \(i), List: \(stringList)")
        }
    }
    
    func testCustomDescendingListSort() {
        var stringList: [String] = ["A", "B", "C", "D"]
        
        print("Befor sort: \(stringList)")
        for i in stride(from: 0, to: stringList.count / 2, by: 1) {
            let index: Int = i + 2
            (stringList[i], stringList[index]) = (stringList[index], stringList[i])
            print("Count: \(i), List: \(stringList)")
        }
        print("After sort: \(stringList)")
        XCTAssert(stringList == ["C", "D", "A", "B"])
    }
}
