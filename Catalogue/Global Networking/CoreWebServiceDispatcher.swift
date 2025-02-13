//
//  CoreWebServiceDispatcher.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import Foundation

/// An object that dispatches requests to a cloud service.
class CoreWebServiceDispatcher: WebServiceDispatcher {
	/// Dispatches data utilizing a `WebServiceRequest`.
	/// - Parameters:
	/// -  request: A `WebServiceRequest` containing the request settings.
	/// - Throws: An error if the URL can't be built or if encountered or returned when sending the URL request.
	/// - Returns: The value returned from the URL decoded to the specified type.
	func dispatch<T: Decodable>(using request: WebServiceRequest) async throws -> T {
		try await self._dispatch(using: request)
	}
	
	/// Builds and sends URL request with the given `WebServiceRequest`.
	/// - Parameters:
	/// -  request: A `WebServiceRequest` containing the request settings.
	/// - Throws: An error if the URL can't be built or if encountered or returned when sending the URL request.
	/// - Returns: The value returned from the URL decoded to the specified type.
	private func _dispatch<T: Decodable>(using request: WebServiceRequest) async throws -> T {
		guard let url = URL(string: Constants.dispatchPath(for: request.endpoint)) else {
			throw NetworkError.invalidURL
		}
		
		var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = request.queries
		var request = URLRequest(url: urlComponents?.url ?? url)
		
		request.httpMethod = request.httpMethod
		request.timeoutInterval = 10
		
		guard !Task.isCancelled else {
			throw NetworkError.unableToDispatch(description: NSLocalizedString("Task cancelled", comment: ""))
		}
		
		let (data, _) = try await URLSession.shared.data(for: request)
		return try decode(data)
	}
	
	/// Decodes data received from request.
	func decode<T: Decodable>(_ data: Data) throws -> T {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
		guard !Task.isCancelled else {
			throw NetworkError.unableToDispatch(description: NSLocalizedString("Task cancelled", comment: ""))
		}
		return try self.decode(data)
	}
}
