//
//  CatBreedDetailProvider.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import Foundation

/// An object that provides CatBreed detail data.
protocol CatBreedDetailProvider {
	/// Sends request to get a single CatBreed based on its id.
	/// - Parameters:
	/// - id: The id of the CatBreed.
	/// - Returns: An `CatBreed` object.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchSingleBreed(id: String) async throws -> CatBreed
}
