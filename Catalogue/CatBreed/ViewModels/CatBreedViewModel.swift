//
//  CatBreedViewModel.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation
import SwiftUI

/// An object that is used to model data with a view.
@Observable
class CatBreedViewModel {
	/// Checks if viewModel is done fetching or not.
	var isFetching = false
	
	/// Array of CatBreeds.
	var catBreeds = [CatBreed]()
	
	/// An object that interacts with a cloud service to get CatBreeds.
	var webService: CatBreedProvider?
	
	/// An object that interacts with a cloud service to get CatBreed details.
	var detailWebService: CatBreedDetailProvider?
	
	/// The current page of the API's request.
	var currentPage: Int = 0
	
	/// Whether or not the view model has been fully loaded.
	var isLoaded = false
	
	/// Whether or not to display an alert to the user.
	var displayErrorAlert = false
	
	/// The title for the alert.
	var alertTitle: LocalizedStringKey?
	
	/// The message for the alert to present to the user.
	var alertMessage: String?
	
	init(
		webService: CatBreedProvider,
		detailWebService: CatBreedDetailProvider? = WebServiceFactory.shared.catBreedDetailProvider()
	) {
		self.webService = webService
		self.detailWebService = detailWebService
	}
	
	/// Refresh the view model by resetting the cat breeds from the web service.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	@MainActor func refresh() async {
		self.currentPage = 0
		let page = self.currentPage
		do {
			let catBreeds = try await self.fetchCatBreeds(for: page)
			self.catBreeds = catBreeds
		} catch {
			self.alertTitle = "Unable to get cat breeds"
			self.alertMessage = error.localizedDescription
			self.displayErrorAlert = true
		}
	}
	
	/// Fetches the next batch of CatBreeds according to the given page.
	/// - Parameters:
	/// - page: The current page for the API request.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	func fetchNextCatBreeds(for page: Int? = nil) async throws {
		guard self.isFetching == false else { return }
		let page = page ?? self.currentPage
		let breeds = try await fetchCatBreeds(for: page)
		self.currentPage = page
		self.catBreeds.appendContentsNotAlreadyContained(contentsOf: breeds)
	}
	
	/// Fetches CatBreeds for the given page.
	/// - Parameters:
	/// - page: The current page for the API request.
	/// - Returns: An array of `CatBreed` objects.
	/// - Throws: A `NetworkError` if unable to build request or encountered during processing of request.
	private func fetchCatBreeds(for page: Int) async throws -> [CatBreed] {
		defer {
			self.isFetching = false
		}
		
		self.isFetching = true
		
		guard let webService else {
			throw NetworkError.unableToDispatch()
		}
		
		return try await webService.fetchBreeds(page: page)
	}
	
	/// Fetches CatBreeds for initial list.
	func fetchInitialCatBreeds() async {
		await self.refresh()
		self.isLoaded = true
	}
}
