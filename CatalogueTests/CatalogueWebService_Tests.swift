//
//  CatalogueWebService_Tests.swift
//  CatalogueTests
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import XCTest
@testable import Catalogue

final class CatalogueWebService_Tests: XCTestCase {
	var webService: CatBreedProvider?
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		webService = nil
    }
	
	func test_WebService_fetchBreeds_shouldFetchBreeds() async throws {
		// Given
		let webService = WebServiceFactory.shared.catBreedProvider()
		
		// When
		let response = try await webService.fetchBreeds(page: 0)
		
		// Then
		XCTAssertNotNil(response)
	}
	
	func test_WebService_fetchBreeds_shouldFetchSpecificPage() async throws {
		// Given
		let webService = WebServiceFactory.shared.catBreedProvider()
		
		// When
		let pages = [0, 1]
		
		// Then
		for page in pages {
			let response = try await webService.fetchBreeds(page: page)
			XCTAssertNotNil(response)
		}
	}
	
	func test_WebService_fetchSingleBreed_shouldFetchSpecificBreed() async throws {
		// Given
		let webService = WebServiceFactory.shared.catBreedDetailProvider()
		
		// When
		let catBreedIds = ["abys", "bomb", "chee"]
		
		// Then
		for id in catBreedIds {
			let response = try await webService.fetchSingleBreed(id: id)
			XCTAssertNotNil(response)
		}
	}
	
	func test_WebService_fetchSingleBreed_shouldDecodeJSON() async throws {
		// Given
		let webService = WebServiceFactory.shared.catBreedDetailProvider()
		let breedId = "abys"
		
		// When
		let response = try await webService.fetchSingleBreed(id: breedId)
		
		// Then
		XCTAssertEqual(breedId, response.id)
	}
	
//	func test_WebService_decoding() throws {
// last: func test if favorite works - in memory - query swiftData and see if its in there
	
}
