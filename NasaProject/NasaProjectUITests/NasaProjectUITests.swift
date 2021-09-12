//
//  NasaProjectUITests.swift
//  NasaProjectUITests
//
//  Created by Simge Çakır on 7.09.2021.
//

import XCTest

class NasaProjectUITests: XCTestCase {
    
    private var app: XCUIApplication!
       
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--UITEST")
       }
    
    func test_FilterButton() throws {
        app.launch()
        let filterButton = app.buttons["filterButton"]
        let cameraFilterField = app.otherElements["cameraFilterField"]

        XCTAssertTrue(filterButton.exists, "filterButton is not exist")
        XCTAssertTrue(filterButton.isEnabled, "filterButton is not enabled")
        
        XCTAssertFalse(cameraFilterField.exists, "cameraFilterField is exist")
        filterButton.tap()
        XCTAssertTrue(cameraFilterField.exists, "cameraFilterField is not exist")
        filterButton.tap()
        XCTAssertFalse(cameraFilterField.exists, "cameraFilterField is exist")
    }
    
    
}
