//
//  ContentView_UITests.swift
//  CatalogueUITests
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import XCTest

final class ContentView_UITests: XCTestCase {

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
	
	func test_ContentView_showFavoritesButton_shouldToggleShowFavorites() throws {
		// Given
		guard let app else { return }
		let showfavoritesbuttonButton = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["ShowFavoritesButton"]/*[[".otherElements[\"Filter\"]",".buttons[\"Filter\"]",".buttons[\"ShowFavoritesButton\"]",".otherElements[\"ShowFavoritesButton\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
		
		// When
		showfavoritesbuttonButton.tap()
		
		let favoriteCatBreedLabel = app.scrollViews.otherElements.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		favoriteCatBreedLabel.tap()
		
		// Then
		XCTAssertTrue(favoriteCatBreedLabel.exists)
	}
	
	func test_ContentView_catBreedNavigationLink_shouldNavigateToDetailView() throws {
		// Given
		guard let app else { return }
		let elementsQuery = app.scrollViews.otherElements
		
		// When
		let catBreedNavigationLink = elementsQuery.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		catBreedNavigationLink.tap()
		
		let destinationText = elementsQuery.staticTexts["The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		destinationText.tap()
	
		// Then
		XCTAssertTrue(destinationText.exists)
	}
	
	func test_ContentView_searchable_shouldSearchQuery() throws {
		// Given
		guard let app else { return }
		let searchable = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].searchFields["Search by breed name…"]
		
		// When
		searchable.tap()
		
		// Then
		XCTAssert(searchable.hasFocus)
	}
	
	func test_ContentView_favoriteButton_shouldToggleFavorited() throws {
		// Given
		guard let app else { return }
		let toggleFavoriteButton = app.scrollViews.otherElements.buttons["American Bobtail, American Bobtails are loving and incredibly intelligent cats possessing a distinctive wild appearance. They are extremely interactive cats that bond with their human family with great devotion."]/*@START_MENU_TOKEN@*/.buttons["toggleFavoriteButton"]/*[[".buttons[\"Love\"]",".buttons[\"toggleFavoriteButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		
		// When
		toggleFavoriteButton.tap()
				
		// Then
		XCTAssertTrue(toggleFavoriteButton.isEnabled)
	}
}
