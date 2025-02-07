//
//  NetworkError.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftUI

/// Enum for possible network errors.
enum NetworkError: Error {
	case missingAPIKey
	case invalidURL
	case missingJSON
	case loadingError
}
