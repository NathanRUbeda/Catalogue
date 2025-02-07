//
//  FavoriteCatBreed.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation
import SwiftData

/// An object that represents a favorited cat breed.
@Model
class FavoriteCatBreed: Identifiable {
	/// ID of the cat breed.
	var id: String
	
	/// Name of the cat breed.
	var name: String
	
	/// Description of the cat breed.
	var breedDescription: String
	
	/// ID of the reference image of the cat breed.
	var referenceImageId: String?
	
	init(
		id: String,
		name: String,
		description: String,
		referenceImageId: String?) {
		self.id = id
		self.name = name
		self.breedDescription = description
		self.referenceImageId = referenceImageId
	}
}

extension FavoriteCatBreed: DisplayableBreed {
	var description: String {
		self.breedDescription
	}
}

extension FavoriteCatBreed: Comparable {
	static func < (lhs: FavoriteCatBreed, rhs: FavoriteCatBreed) -> Bool {
		lhs.name < rhs.name
	}
}
