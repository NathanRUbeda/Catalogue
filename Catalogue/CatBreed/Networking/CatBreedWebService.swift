//
//  CatBreedWebService.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// A web service for handling networking for the CatBreed object.
class CatBreedWebService: WebService, CatBreedProvider {
	/// Sends request to get CatBreeds.
	/// - Parameters:
	/// - page: The page of the API request.
	/// - Returns: An array of `CatBreed`.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchBreeds(page: Int) async throws -> [CatBreed] {
		guard let privateKey = ProcessInfo.processInfo.environment["API_Secret_Key"] else {
			throw NetworkError.missingAPIKey
		}
		
		return try await self.dispatch(
			using: WebServiceRequest(
				httpMethod: "GET",
				endpoint: "breeds",
				headers: ["x-api-key" : privateKey],
				queries: [
					URLQueryItem(name: "limit", value: "15"),
					URLQueryItem(name: "page", value: String(page))
				]
			)
		)
	}
}
