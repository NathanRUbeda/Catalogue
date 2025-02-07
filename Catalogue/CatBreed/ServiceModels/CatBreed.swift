//
//  CatBreed.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object that represents a cat breed.
struct CatBreed: Codable, Identifiable, Equatable, Comparable {
	static func < (lhs: CatBreed, rhs: CatBreed) -> Bool {
		lhs.name < rhs.name
	}
	
	/// ID of the cat breed.
	var id: String
	
	/// Name of the cat breed.
	var name: String
	
	/// Temperament of the cat breed.
	var temperament: String
	
	/// Origin of the cat breed.
	var origin: String
	
	/// Description of the cat breed.
	var description: String
	
	/// Life span of the cat breed.
	var lifeSpan: String
	
	/// Indoor level of the cat breed.
	var indoor: Int
	
	/// Adaptability level of the cat breed.
	var adaptability: Int
	
	/// Affection level of the cat breed.
	var affectionLevel: Int
	
	/// Child friendliness level of the cat breed.
	var childFriendly: Int
	
	/// Dog friendliness level of the cat breed.
	var dogFriendly: Int
	
	/// Energy level of the cat breed.
	var energyLevel: Int
	
	/// Grooming level of the cat breed.
	var grooming: Int
	
	/// Health issues level of the cat breed.
	var healthIssues: Int
	
	/// Intelligence level of the cat breed.
	var intelligence: Int
	
	/// Shedding level of the cat breed.
	var sheddingLevel: Int
	
	/// ID of the reference image of the cat breed.
	var referenceImageId: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case temperament
		case origin
		case description
		case lifeSpan = "life_span"
		case indoor
		case adaptability
		case affectionLevel = "affection_level"
		case childFriendly = "child_friendly"
		case dogFriendly = "dog_friendly"
		case energyLevel = "energy_level"
		case grooming
		case healthIssues = "health_issues"
		case intelligence
		case sheddingLevel = "shedding_level"
		case referenceImageId = "reference_image_id"
	}
}

extension CatBreed: DisplayableBreed {}
