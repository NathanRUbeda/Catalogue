//
//  WebServiceFactory.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object to vend web services.
class WebServiceFactory {
	/// The dispatcher to use for networking.
	var dispatcher: WebServiceDispatcher!
	
	/// A shared instance of the factory to vend web services.
	static let shared = WebServiceFactory()
	
	/// A method that returns a CatBreedProvider.
	/// - Returns: A `CatBreedProvider` object.
	func catBreedProvider() -> CatBreedProvider {
		CatBreedWebService(dispatcher: self.dispatcher)
	}
	
	/// A method that returns a CatBreedDetailProvider.
	/// - Returns: A `CatBreedDetailProvider` object.
	func catBreedDetailProvider() -> CatBreedDetailProvider {
		CatBreedDetailWebService(dispatcher: self.dispatcher)
	}
}
