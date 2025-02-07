//
//  SplashScreenView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftUI

/// Displays a splash screen or a ContentView, if active.
struct SplashScreenView: View {
	// MARK: Environment injected properties
	@Environment(\.isInternetConnected) var isInternetConnected
	
    var body: some View {
		if self.isInternetConnected {
			self.splashScreen
		} else {
			OfflineView()
		}
    }
	
	/// Displays the logo and name of the app, and a ProgressView in a vertical stack.
	private var splashScreen: some View {
		VStack {
			Image(systemName: "cat.fill")
				.font(.system(size: 200))
				.foregroundStyle(.primary)
			
			Image("catalogue")
				.resizable()
				.scaledToFit()
				.frame(width: 300)
			
			ProgressView()
				.frame(height: 140)
				.scaleEffect(3)
		}
	}
}
