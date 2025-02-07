//
//  CatBreedDetailWebService.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import Foundation

/// A web service for handling detail networking operations.
class CatBreedDetailWebService: WebService, CatBreedDetailProvider {
	/// Sends request to get CatBreed based on its id.
	/// - Parameters:
	/// - id: The id of the CatBreed.
	/// - Returns: A `CatBreed` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchSingleBreed(id: String) async throws -> CatBreed {
		guard let privateKey = ProcessInfo.processInfo.environment["API_Secret_Key"] else {
			throw NetworkError.missingAPIKey
		}
				
		return try await self.dispatch(using: WebServiceRequest(
			httpMethod: "GET",
			endpoint: "breeds/\(id)",
			headers: ["x-api-key" : privateKey],
			queries: nil
		)
		)
	}
}
