//
//  MockWebService.swift
//  CatalogueTests
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import Foundation
@testable import Catalogue

/// An object that mimics an interaction with a cloud service using a JSON file.
class MockWebService: WebService, CatBreedProvider, CatBreedDetailProvider {
	/// Sends request to get CatBreeds.
	/// - Parameters:
	/// - page: The page of the API request.
	/// - Returns: An array of `CatBreed`.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchBreeds(page: Int) async throws -> [CatBreed] {
		let url: URL? = switch page {
			case 0:
				Bundle.main.url(forResource: "mock15CatBreedsPage0JSON", withExtension: "json")
			case 1:
				Bundle.main.url(forResource: "mock15CatBreedsPage1JSON", withExtension: "json")
			default:
				nil
		}
		
		guard let jsonURL = url else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		return try decode(data)
	}
	
	/// Sends request to get a single CatBreed based on its id.
	/// - Parameters:
	/// - id: The id of the CatBreed.
	/// - Returns: An `CatBreed` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchSingleBreed(id: String) async throws -> CatBreed {
		let url: URL? = switch id {
			case "abys":
				Bundle.main.url(forResource: "mockAbyssinianJSON", withExtension: "json")
			case "bomb":
				Bundle.main.url(forResource: "mockBombayJSON", withExtension: "json")
			case "chee":
				Bundle.main.url(forResource: "mockCheetohJSON", withExtension: "json")
			default:
				nil
		}
		
		guard let jsonURL = url else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		return try decode(data)
	}
}
