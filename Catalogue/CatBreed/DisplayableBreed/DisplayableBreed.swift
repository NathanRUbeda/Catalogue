//
//  DisplayableBreed.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import Foundation

/// A protocol to represent a cat breed that can be generically displayed.
protocol DisplayableBreed {
	/// The ID of the cat breed.
	var id: String { get }
	
	/// The name of the cat breed.
	var name: String { get }
	
	/// A description of the cat breed.
	var description: String { get }
	
	/// The image reference ID of the cat breed.
	var referenceImageId: String? { get }
}
