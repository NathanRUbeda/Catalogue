//
//  Constants.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import Foundation

/// A namespace for constant values that do not change across the application.
enum Constants {
	static let catImageBaseURL = "https://cdn2.thecatapi.com/images/"
	static func catImageURL(for id: String) -> URL? {
		let endpoint = Self.catImageBaseURL + id + ".jpg"
		return URL(string: endpoint)
	}
	static let catBaseURLEndpoint = "http://api.thecatapi.com/v1/"
	static func dispatchPath(for endpoint: String) -> String {
		Self.catBaseURLEndpoint + endpoint
	}
}
