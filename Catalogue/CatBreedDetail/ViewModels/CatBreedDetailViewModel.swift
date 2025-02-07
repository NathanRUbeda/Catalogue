//
//  CatBreedDetailViewModel.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import Foundation

/// An object that is used to model data with a CatBreed detail view.
@Observable
final class CatBreedDetailViewModel {
	/// ID of the cat breed.
	var id: String
	
	/// Name of the cat breed.
	var name: String?
	
	/// Temperament of the cat breed.
	var temperament: String?
	
	/// Origin of the cat breed.
	var origin: String?
	
	/// Description of the cat breed.
	var description: String?
	
	/// Life span of the cat breed.
	var lifeSpan: String?
	
	/// Indoor level of the cat breed.
	var indoor: Int?
	
	/// Adaptability level of the cat breed.
	var adaptability: Int?
	
	/// Affection level of the cat breed.
	var affectionLevel: Int?
	
	/// Child friendliness level of the cat breed.
	var childFriendly: Int?
	
	/// Dog friendliness level of the cat breed.
	var dogFriendly: Int?
	
	/// Energy level of the cat breed.
	var energyLevel: Int?
	
	/// Grooming level of the cat breed.
	var grooming: Int?
	
	/// Health issues level of the cat breed.
	var healthIssues: Int?
	
	/// Intelligence level of the cat breed.
	var intelligence: Int?
	
	/// Shedding level of the cat breed.
	var sheddingLevel: Int?
	
	/// ID of the reference image of the cat breed.
	var referenceImageId: String?
	
	/// An object that is used to build the view model.
	private(set) var serviceObject: CatBreed?
	
	/// An object that interacts with a cloud service.
	var webService: CatBreedDetailProvider?
	
	/// Whether or not the detail view model has been fully loaded.
	var isLoaded = false
	
	/// Whether or not to display an alert to the user.
	var displayErrorAlert = false
	
	/// The message for the alert to present to the user.
	var alertMessage: String?
	
	/// Designated initializer.
	/// - Parameters:
	/// - id: The id of the CatBreed.
	/// - webService: The CatBreed detail provider to use for fetching detail data.
	init(
		for id: String,
		 using webService: CatBreedDetailProvider? = WebServiceFactory.shared.catBreedDetailProvider()
	) {
		self.id = id
		self.webService = webService
	}
	
	/// Instantiate a new view model from the given response object. If the reponse is `nil`, the initializer fails.
	init?(from response: CatBreed?) {
		guard let response else {
			return nil
		}
		
		self.serviceObject = response
		self.id = response.id
		self.webService = WebServiceFactory.shared.catBreedDetailProvider()
		if let serviceObject {
			self._update(from: serviceObject)
			self.isLoaded = true
		}
	}
	
	/// Instantiate a new view model from the given cat breed.
	init(from catBreed: CatBreed) {
		self.id = catBreed.id
		self.name = catBreed.name
		self.temperament = catBreed.temperament
		self.origin = catBreed.origin
		self.description = catBreed.description
		self.lifeSpan = catBreed.lifeSpan
		self.indoor = catBreed.indoor
		self.adaptability = catBreed.adaptability
		self.affectionLevel = catBreed.affectionLevel
		self.childFriendly = catBreed.childFriendly
		self.dogFriendly = catBreed.dogFriendly
		self.energyLevel = catBreed.energyLevel
		self.grooming = catBreed.grooming
		self.healthIssues = catBreed.healthIssues
		self.intelligence = catBreed.intelligence
		self.sheddingLevel = catBreed.sheddingLevel
		self.referenceImageId = catBreed.referenceImageId
	}
	
	/// Refreshes data by calling the network again.
	@MainActor func refresh() async {
		await self.fetchCatBreed(id: self.id)
	}
	
	/// Fetches a CatBreed based on its id.
	private func fetchCatBreed(id: String) async {
		do {
			let response = try await self.webService?.fetchSingleBreed(id: id)
			self.serviceObject = response
			if let serviceObject {
				self._update(from: serviceObject)
			}
		} catch {
			self.alertMessage = error.localizedDescription
			self.displayErrorAlert = true
		}
	}
	
	/// Updates the values of the object.
	/// - Parameters:
	/// - serviceObject: An object that is used to build the view model.
	private func _update(from serviceObject: CatBreed) {
		self.name = serviceObject.name
		self.temperament = serviceObject.temperament
		self.origin = serviceObject.origin
		self.description = serviceObject.description
		self.lifeSpan = serviceObject.lifeSpan
		self.indoor = serviceObject.indoor
		self.adaptability = serviceObject.adaptability
		self.affectionLevel = serviceObject.affectionLevel
		self.childFriendly = serviceObject.childFriendly
		self.dogFriendly = serviceObject.dogFriendly
		self.energyLevel = serviceObject.energyLevel
		self.grooming = serviceObject.grooming
		self.healthIssues = serviceObject.healthIssues
		self.intelligence = serviceObject.intelligence
		self.sheddingLevel = serviceObject.sheddingLevel
		self.referenceImageId = serviceObject.referenceImageId
	}
}
