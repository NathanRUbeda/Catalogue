//
//  WebService.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object that interacts with a cloud service.
class WebService {
	/// The dispatcher to use for networking.
	private var dispatcher: WebServiceDispatcher
	
	init(dispatcher: WebServiceDispatcher) {
		self.dispatcher = dispatcher
	}
	
	/// Dispatches data utilizing a `WebServiceRequest`.
	/// - Parameters:
	/// -  request: A `WebServiceRequest` containing the request settings.
	/// - Throws: An error if the URL can't be built or if encountered or returned when sending the URL request.
	/// - Returns: The value returned from the URL decoded to the specified type.
	func dispatch<T: Decodable>(using request: WebServiceRequest) async throws -> T {
		try await self.dispatcher.dispatch(using: request)
	}
	
	/// Decodes data received from request.
	func decode<T: Decodable>(_ data: Data) throws -> T {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	}
}
