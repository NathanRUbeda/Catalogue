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
		app.launchEnvironment = ["IS_TEST": "TRUE"]
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		self.app = nil
    }

	func test_ContentView_showFavoritesButton_shouldToggleShowFavorites() throws {
		// Given
		guard let app else {
			return
		}
		let showfavoritesbuttonButton = app.buttons["ShowFavoritesButton"]
		
		// When
		showfavoritesbuttonButton.tap()
		
		let favoriteCatBreedLabel = app.scrollViews.otherElements.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		favoriteCatBreedLabel.tap()
		
		// Then
		XCTAssertTrue(favoriteCatBreedLabel.exists)
	}
	
	func test2_ContentView_showFavoritesButton_shouldToggleShowFavorites() throws {
		// Given
		guard let app else {
			return
		}
		
		let favoritesButton = app.buttons["ShowFavoritesButton"]
		// Get the first item in the scroll view. `NavigationLink` is a button underneath everything.
		let firstItem = app.scrollViews.buttons.firstMatch
		XCTAssert(favoritesButton.exists)
		XCTAssertTrue(firstItem.exists)
		
		// When
		favoritesButton.tap()
		firstItem.tap()
	
		// Then
		XCTAssert(favoritesButton.isEnabled)
	}
	
	
	func test_ContentView_showFavoritesButton_shouldToggle() throws {
		// Given
		guard let app else {
			return
		}
		
		app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["line.3.horizontal.decrease.circle.fill"]/*[[".otherElements[\"Filter\"]",".buttons[\"Filter\"]",".buttons[\"line.3.horizontal.decrease.circle.fill\"]",".otherElements[\"line.3.horizontal.decrease.circle.fill\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let elementsQuery = app.scrollViews.otherElements
		elementsQuery.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."].tap()
		elementsQuery.staticTexts["The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."].tap()
		
		XCTAssertTrue(elementsQuery.staticTexts["The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."].exists)
	}
	
	func test_ContentView_catBreedNavigationLink_shouldNavigateToDetailView() throws {
		// Given
		guard let app else {
			return
		}
		
		// When
		let elementsQuery = app.scrollViews.otherElements
		let catBreedNavigationLink = elementsQuery.buttons["Abyssinian, The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		catBreedNavigationLink.tap()
		
		let destinationText = elementsQuery.staticTexts["The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."]
		destinationText.tap()
	
		// Then
		XCTAssertTrue(destinationText.exists)
	}
	
	func test_ContentView_searchable_shouldSearchQuery() throws {
		// Given
		guard let app else {
			return
		}
		
		let searchable = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].searchFields["Search by breed name…"]
		
		// When
		searchable.tap()
		
		// Then
		XCTAssert(searchable.hasFocus)
	}
	
	func test_ContentView_favoriteButton_shouldToggleFavorited() throws {
		// Given
		guard let app else {
			return
		}
		
		let toggleFavoriteButton = app.scrollViews.otherElements.buttons["American Bobtail, American Bobtails are loving and incredibly intelligent cats possessing a distinctive wild appearance. They are extremely interactive cats that bond with their human family with great devotion."]/*@START_MENU_TOKEN@*/.buttons["toggleFavoriteButton"]/*[[".buttons[\"Love\"]",".buttons[\"toggleFavoriteButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		
		// When
		toggleFavoriteButton.tap()
				
		// Then
		XCTAssertTrue(toggleFavoriteButton.isEnabled)
	}
}
