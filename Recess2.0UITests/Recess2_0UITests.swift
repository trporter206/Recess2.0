//
//  Recess2_0UITests.swift
//  Recess2.0UITests
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import XCTest

final class Recess2_0UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListToDetail() {
        let sportsClubPredicate = NSPredicate(format: "label beginswith 'Sports Club'")
        app.buttons.element(matching: sportsClubPredicate).tap()
        app.navigationBars.buttons["Back"].tap()
        
        let tennisClubPredicate = NSPredicate(format: "label beginswith 'Tennis Club'")
        app.buttons.element(matching: tennisClubPredicate).tap()
        app.navigationBars.buttons["Back"].tap()
    }

}
