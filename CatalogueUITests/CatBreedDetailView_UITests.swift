//
//  CatBreedDetailView_UITests.swift
//  CatalogueUITests
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import XCTest

final class CatBreedDetailView_UITests: XCTestCase {
	
	var app: XCUIApplication?

    override func setUpWithError() throws {
        continueAfterFailure = false
		let app = XCUIApplication()
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		app = nil
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
	
	func test_CatBreedDetailView_favoriteButton_shouldToggleFavorited() throws {
		// Given
		guard let app else { return }
		app.scrollViews.otherElements.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."].tap()
		let abyssinianNavigationBar = app.navigationBars["Abyssinian"]
		
		// When
		abyssinianNavigationBar/*@START_MENU_TOKEN@*/.buttons["heart"]/*[[".otherElements[\"Love\"]",".buttons[\"Love\"]",".buttons[\"heart\"]",".otherElements[\"heart\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		// Then
	}
	
	func test_CatBreedDetailView_backButton_shouldReturnToPreviousView() throws {
		// Given
		guard let app else { return }
		let catBreedNavigationLink = app.scrollViews.otherElements.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		
		
		// When
		catBreedNavigationLink.tap()
		
		let backButton = app.navigationBars["Abyssinian"].buttons["Back"]
		backButton.tap()
		
		let titleImage = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].images["catalogue"]
		titleImage.tap()
		
		// Then
		XCTAssertTrue(titleImage.exists)
	}
}
