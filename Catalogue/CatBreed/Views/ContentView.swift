//
//  ContentView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//


import SwiftUI

import SwiftData
import SwiftUI

/// Displays a NavigationStack with a ScrollView containg all the CatBreeds.
struct ContentView: View {
	// MARK: Environment injected properties
	@Environment(\.isInternetConnected) var isInternetConnected
	@Environment(\.modelContext) var modelContext
	@Query var favorites: [FavoriteCatBreed]
	
	// MARK: Injected properties
	/// The view model to handle displaying and refreshing cat breeds.
	@Bindable var viewModel: CatBreedViewModel
	
	// MARK: Local properties
	/// An array of filtered and sorted cat breeds.
	///
	/// This property exits early when there is no query.
	private var filteredAndSortedCatBreeds: [CatBreed] {
		guard !self.query.isEmpty else {
			return self.viewModel.catBreeds.sorted()
		}
		
		return self.viewModel.catBreeds.filter { $0.name.localizedCaseInsensitiveContains(self.query) }.sorted()
	}
	
	/// An array of sorted favorited cat breeds.
	///
	/// This property exits early when there is no query.
	private var sortedFavoritedCatBreeds: [FavoriteCatBreed] {
		guard !self.query.isEmpty else {
			return self.favorites.sorted()
		}
		
		return self.favorites.filter { $0.name.localizedCaseInsensitiveContains(self.query) }.sorted()
	}
	
	/// Whether or not to show the favorited cat breeds.
	@State private var showFavorites = false
	
	/// The search query.
	@State private var query = ""
	
	/// The cat breed visible based on the scroll position.
	@State private var visibleCatBreedID: CatBreed.ID?
	
	/// Whether or not to display a no internet alert.
	@State private var displayNoInternetAlert = false
	
	var body: some View {
		ScrollViewReader { proxy in
			ScrollView {
				VStack {
					if self.showFavorites {
						if !favorites.isEmpty {
							self.favoritedBreedsForEach
						} else {
							self.noFavoritesText
						}
					} else {
						self.breedsForEach
					}
				}
				.padding(.horizontal)
				.scrollTargetLayout()
			}
			.scrollIndicators(.hidden)
			.searchable(
				text: self.$query,
				prompt: "Search by breed name…"
			)
			.toolbar {
				if self.viewModel.isFetching {
					ToolbarItem(placement: .cancellationAction) {
						ProgressView()
					}
				}
				
				ToolbarItem(placement: .principal) {
					Image("catalogue")
						.resizable()
						.scaledToFit()
						.frame(height: 26)
						.padding()
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button {
						self.showFavorites.toggle()
					} label: {
						Image(systemName: self.showFavorites ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
							.font(.body)
							.foregroundStyle(.secondary)
					}
					.buttonStyle(.plain)
					.accessibilityIdentifier("ShowFavoritesButton")
				}
			}
			.scrollPosition(
				id: self.$visibleCatBreedID,
				anchor: .bottom
			)
			.onChange(of: self.visibleCatBreedID) { _, newValue in
				fetchNewPages(newValue: newValue)
			}
			.alert("Unable to refresh without internet", isPresented: self.$displayNoInternetAlert) {
				Button("OK") {
					self.displayNoInternetAlert = false
				}
			}
			.alert(
				self.viewModel.alertTitle ?? "Error occurred",
				isPresented: self.$viewModel.displayErrorAlert,
				actions: {
					Button("OK") {
						self.viewModel.displayErrorAlert = false
						self.viewModel.alertTitle = nil
						self.viewModel.alertMessage = nil
					}
				},
				message: {
					if let message = self.viewModel.alertMessage {
						Text(message)
					}
				}
			)
		}
	}
	
	/// Displays a ForEach for the favorited breeds, containing a NavigationLink labeled as a BreedLabel.
	private var favoritedBreedsForEach: some View {
		ForEach(self.sortedFavoritedCatBreeds) { favoritedBreed in
			let isFavorited = self.favorites.contains(where: { $0.name == favoritedBreed.name })
			
			NavigationLink {
				CatBreedDetailView(for: favoritedBreed.id, webService: self.viewModel.detailWebService, isFavorited: isFavorited, toggleFavorited: { toggleFavorited(catBreed: favoritedBreed) })
			} label: {
				BreedLabel(
					breed: favoritedBreed,
					isFavorited: isFavorited,
					toggleFavorited: {
						self.toggleFavorited(catBreed: favoritedBreed)
					}
				)
			}
			.buttonStyle(.plain)
			.accessibilityIdentifier("FavoriteCatBreedNavigationLink")
		}
	}
	
	/// Displays a text indicating the absence of favorites.
	private var noFavoritesText: some View {
		Text("No favorite breeds yet.")
			.fontWeight(.regular)
			.foregroundStyle(.secondary)
	}
	
	/// Displays a ForEach for the cat breeds, containing a NavigationLink labeled as a BreedLabel.
	private var breedsForEach: some View {
		ForEach(self.filteredAndSortedCatBreeds) { breed in
			let isFavorited = self.favorites.contains(where: { $0.name == breed.name })
			
			NavigationLink {
				CatBreedDetailView(for: breed.id, webService: self.viewModel.detailWebService, isFavorited: isFavorited, toggleFavorited: { toggleFavorited(catBreed: breed) })
			} label: {
				BreedLabel(
					breed: breed,
					isFavorited: isFavorited,
					toggleFavorited: {
						self.toggleFavorited(catBreed: breed)
					}
				)
			}
			.buttonStyle(.plain)
			.accessibilityIdentifier("CatBreedNavigationLink")
		}
	}
	
	/// Selects or deselects a cat breed as a favorite.
	/// - Parameters:
	/// -  catBreed: A cat breed object that conforms to the `DisplayableBreed` protocol.
	func toggleFavorited(catBreed: DisplayableBreed) {
		if let existingFavorite = self.favorites.first(where: { $0.name == catBreed.name}) {
			self.modelContext.delete(existingFavorite)
			return
		}
		
		let newFavorite = FavoriteCatBreed(id: catBreed.id, name: catBreed.name, description: catBreed.description, referenceImageId: catBreed.referenceImageId ?? "N/A")
		
		self.modelContext.insert(newFavorite)
		
		do {
			try self.modelContext.save()
		} catch {
			self.viewModel.alertTitle = "Unable to favorite cat breed"
			self.viewModel.alertMessage = error.localizedDescription
			self.viewModel.displayErrorAlert = true
		}
	}
	
	/// Fetches new data pages from the API when the user gets close to the bottom of the list.
	/// - Parameters:
	/// -  newValue: The new CatBreed's ID.
	func fetchNewPages(newValue: CatBreed.ID?) {
		guard let currentIndex = self.viewModel.catBreeds.firstIndex(where: { $0.id == newValue }) else {
			return
		}
		let lastIndex = self.viewModel.catBreeds.endIndex
		
		let endingRemainder = lastIndex - currentIndex
		if endingRemainder <= 2 {
			Task {
				do {
					let currentPage = self.viewModel.currentPage + 1
					try await self.viewModel.fetchNextCatBreeds(for: currentPage)
				} catch {
					self.viewModel.alertMessage = error.localizedDescription
					self.viewModel.displayErrorAlert = true
				}
			}
		}
	}
}
