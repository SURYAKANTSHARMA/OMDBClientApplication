//
//  OMDBClientApplicationTests.swift
//  OMDBClientApplicationTests
//
//  Created by Mac mini on 10/8/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import XCTest
@testable import OMDBClientApplication

class OMDBClientApplicationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let year = "2008"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.date(from: year)!
        XCTAssert(date.getElapsedInterval() == "10 years", "Both Expression should be equal ")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
