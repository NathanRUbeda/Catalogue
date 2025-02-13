//
//  CatalogueApp.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftData
import SwiftUI

@main
struct CatalogueApp: App {
	/// A network monitor for analyzing user's network online status.
	@State var networkMonitor = NetworkMonitor()
	
	/// The view model to display and manage cat breeds.
	let viewModel: CatBreedViewModel
	
	init() {
		WebServiceFactory.shared.dispatcher = CoreWebServiceDispatcher()
		let webService: CatBreedProvider
		
		let isTestEnvironment = ProcessInfo.processInfo.environment["IS_TEST"]
		if isTestEnvironment == "TRUE" {
			webService = MockWebService()
		} else {
			webService = WebServiceFactory.shared.catBreedProvider()
		}
		self.viewModel = .init(webService: webService)
	}
	
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				if self.viewModel.isLoaded {
					ContentView(viewModel: self.viewModel)
				} else {
					SplashScreenView()
				}
			}
			.task {
				if !self.viewModel.isLoaded {
					await self.viewModel.fetchInitialCatBreeds()
				}
			}
		}
		.modelContainer(for: FavoriteCatBreed.self)
		.environment(\.isInternetConnected, self.networkMonitor.isConnected)
	}
}
