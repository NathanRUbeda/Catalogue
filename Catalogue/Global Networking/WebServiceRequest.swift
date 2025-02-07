//
//  WebServiceRequest.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object that represents a web service request.
struct WebServiceRequest {
	let httpMethod: String
	let endpoint: String
	let headers: [String: Any]?
	let queries: [URLQueryItem]?
}
