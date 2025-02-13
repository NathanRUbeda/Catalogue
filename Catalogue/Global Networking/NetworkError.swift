//
//  NetworkError.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftUI

/// Enum for possible network errors.
enum NetworkError: Error, CustomStringConvertible, LocalizedError {
	case missingAPIKey
	case invalidURL
	case missingJSON
	case loadingError
	case unableToDispatch(description: String? = nil)
	
	var description: String {
		switch self {
			case .invalidURL:
				return NSLocalizedString("Wrong URL used in networking call.", comment: "")
			case .loadingError:
				return NSLocalizedString("Unable to load", comment: "")
			case .missingAPIKey:
				return NSLocalizedString("Missing API key.", comment: "")
			case .missingJSON:
				return NSLocalizedString("Missing JSON data.", comment: "")
			case let .unableToDispatch(description):
				return description ?? NSLocalizedString("Unable to dispatch task.", comment: "")
		}
	}
	
	var errorDescription: String? {
		self.description
	}
}
