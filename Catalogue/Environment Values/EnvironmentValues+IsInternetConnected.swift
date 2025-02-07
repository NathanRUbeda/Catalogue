//
//  EnvironmentValues+IsInternetConnected.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import SwiftUI

extension EnvironmentValues {
	/// An enumeration for capturing user's device internet connection for environment.
	private enum IsInternetConnected: EnvironmentKey {
		static var defaultValue: Bool = false
	}
	
	/// Whether or not the user is currently connected to the internet.
	var isInternetConnected: Bool {
		get { self[IsInternetConnected.self] }
		set { self[IsInternetConnected.self] = newValue }
	}
}
