//
//  SetTests.swift
//  SetTests
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import XCTest
@testable import Set

class SetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetWithAllDifferentFeats() {
        let testSet = Set([
            PlayingCard(color: .green, shape: .rectangle, value: .one, filling: .empty),
            PlayingCard(color: .orange, shape: .oval, value: .two, filling: .speckled),
            PlayingCard(color: .purple, shape: .tilde, value: .three, filling: .full)
            ])
        let valid = Validator.checkSet(testSet)
        XCTAssert(valid == true, "Failed validating set with all different features.")
    }
    
    func testValidSetWithMixedFeats() {
        let testSet = Set([
            PlayingCard(color: .green, shape: .rectangle, value: .one, filling: .speckled),
            PlayingCard(color: .green, shape: .oval, value: .two, filling: .speckled),
            PlayingCard(color: .green, shape: .tilde, value: .three, filling: .speckled)
            ])
        let valid = Validator.checkSet(testSet)
        XCTAssert(valid == true, "Failed validating set with all mixed features.")
    }
    
    func testInvalidSet() {
        let testSet = Set([
            PlayingCard(color: .green, shape: .oval, value: .one, filling: .empty),
            PlayingCard(color: .orange, shape: .oval, value: .two, filling: .speckled),
            PlayingCard(color: .purple, shape: .oval, value: .three, filling: .speckled)
            ])
        let valid = Validator.checkSet(testSet)
        XCTAssert(valid == false, "Failed validating set with all mixed features.")
    }
    
}
