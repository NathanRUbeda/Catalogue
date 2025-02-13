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
		app.launchEnvironment = ["IS_TEST": "TRUE"]
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		app = nil
    }
	
	func test_CatBreedDetailView_favoriteButton_shouldToggleFavorited() throws {
		// Given
		guard let app else { return }
		
		// When
		app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["CatBreedAmerican CurlButton"]/*[[".buttons[\"American Curl, Distinguished by truly unique ears that curl back in a graceful arc, offering an alert, perky, happily surprised expression, they cause people to break out into a big smile when viewing their first Curl. Curls are very people-oriented, faithful, affectionate soulmates, adjusting remarkably fast to other pets, children, and new situations.\"]",".buttons[\"CatBreedAmerican CurlButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let americanCurlNavigationBar = app.navigationBars["American Curl"]
		americanCurlNavigationBar/*@START_MENU_TOKEN@*/.buttons["heart"]/*[[".otherElements[\"Love\"]",".buttons[\"Love\"]",".buttons[\"heart\"]",".otherElements[\"heart\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
						
		// Then
		XCTAssert(americanCurlNavigationBar/*@START_MENU_TOKEN@*/.buttons["heart.fill"]/*[[".otherElements[\"Love\"]",".buttons[\"Love\"]",".buttons[\"heart.fill\"]",".otherElements[\"heart.fill\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
	}
	
	func test_CatBreedDetailView_backButton_shouldReturnToPreviousView() throws {
		// Given
		guard let app else {
			return
		}
		
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
