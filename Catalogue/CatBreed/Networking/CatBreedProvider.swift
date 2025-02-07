//
//  CatBreedProvider.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object that provides CatBreeds.
protocol CatBreedProvider {
	/// Sends request to get CatBreeds.
	/// - Parameters:
	/// - page: The page of the API request.
	/// - Returns: An array of `CatBreed`.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchBreeds(page: Int) async throws -> [CatBreed]
}
