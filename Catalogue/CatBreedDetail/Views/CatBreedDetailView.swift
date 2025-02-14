//
//  CatBreedDetailView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftUI

/// Displays a NavigationStack with a ScrollView containing detailed information about a cat breed.
struct CatBreedDetailView<ImageView: View>: View {
	// MARK: Environment injected properties
	@Environment(\.isInternetConnected) var isInternetConnected
	
	// MARK: Injected properties
	/// Whether or not the cat breed is favorited.
	let isFavorited: Bool
	
	/// A closure envoked by the user to toggle the favorites for this cat breed.
	let toggleFavorited: () -> Void
	
	/// The view model for the detail view.
	@State var viewModel: CatBreedDetailViewModel
	
	/// The cat breed image view to display.
	let imageView: ImageView
	
	// MARK: Local properties
	private var information: [String: String] {
		[
			"Temperament": self.viewModel.temperament ?? "N/A",
			"Origin": self.viewModel.origin ?? "N/A",
			"Life Span": self.viewModel.lifeSpan ?? "N/A"
		]
	}
	
	private var stats: [String: Int] {
		let stats = [
			"Indoor": viewModel.indoor,
			"Adaptability": viewModel.adaptability,
			"Affection Level": viewModel.affectionLevel,
			"Child-Friendly": viewModel.childFriendly,
			"Dog-Friendly": viewModel.dogFriendly,
			"Energy Level": viewModel.energyLevel,
			"Grooming": viewModel.grooming,
			"Health Issues": viewModel.healthIssues,
			"Intelligence": viewModel.intelligence,
			"Shedding Level": viewModel.sheddingLevel
		]
		
		return stats.compactMapValues { $0 }
	}
	
	/// Create a new `CatBreedDetailView` with the given cat breed ID.
	init(
		for breedId: String,
		webService: CatBreedDetailProvider? = nil,
		isFavorited: Bool,
		toggleFavorited: @escaping () -> Void,
		imageView: ImageView
	) {
		self.viewModel = .init(for: breedId, using: webService)
		self.isFavorited = isFavorited
		self.toggleFavorited = toggleFavorited
		self.imageView = imageView
	}
	
	var body: some View {
		if self.viewModel.isLoaded == false, self.isInternetConnected == false {
			OfflineView()
				.onChange(of: self.isInternetConnected) { _, newValue in
					if newValue {
						Task {
							await self.viewModel.refresh()
						}
					}
				}
		} else {
			self.content
		}
	}
	
	/// The main content for the detail view.
	private var content: some View {
		ScrollView {
			VStack(alignment: .leading) {
				BreedImageContainerView(width: 370, height: 200, cornerRadius: 20, imageView: self.imageView)
					.padding(.vertical)
				
				Divider()
				
				if let description = self.viewModel.description {
					Text(description)
						.font(.headline)
						.fontWeight(.regular)
						.foregroundStyle(.secondary)
						.padding(.vertical)
				}
				
				Divider()
				
				self.informationVStack
				
				Divider()
				
				self.statsForEach
				
				Spacer()
			}
		}
		.padding(.horizontal)
		.scrollIndicators(.hidden)
		.refreshable {
			await self.viewModel.refresh()
		}
		.task {
			await self.viewModel.refresh()
		}
		.navigationTitle(self.viewModel.name ?? "Cat Breed")
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button {
					toggleFavorited()
				} label: {
					Image(systemName: self.isFavorited ? "heart.fill" : "heart")
						.foregroundStyle(.secondary)
				}
				.buttonStyle(.plain)
			}
		}
		.alert(
			"Unable to get cat breed details",
			isPresented: Binding(get: {  self.viewModel.displayErrorAlert }, set: {  self.viewModel.displayErrorAlert = $0 }),
			actions: {
				Button("OK") {
					self.viewModel.displayErrorAlert = false
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
	
	/// Displays a vertical stack of the information about the cat breed.
	private var informationVStack: some View {
		VStack(alignment: .leading, spacing: 6) {
			ForEach(self.information.sorted(by: <), id: \.key) { key, value in
				VStack(alignment: .leading, spacing: 3) {
					Text("\(key)")
						.font(.headline)
						.fontWeight(.semibold)
						.foregroundStyle(.secondary)
					
					Text(value)
						.font(.headline)
						.fontWeight(.regular)
						.foregroundStyle(.primary)
				}
			}
		}
		.padding(.vertical)
	}
	
	/// Displays a `ForEach` of the stats about the cat breed.
	private var statsForEach: some View {
		ForEach(self.stats.sorted(by: <), id: \.key) { key, value in
			HStack {
				Text(key)
					.font(.headline)
					.fontWeight(.semibold)
					.foregroundStyle(.secondary)
				
				Spacer()
				
				ForEach(0..<5) { index in
					if value > index {
						Image(systemName: "pawprint.fill")
							.font(.title2)
							.foregroundStyle(.primary)
					} else {
						Image(systemName: "pawprint.fill")
							.font(.title2)
							.foregroundStyle(.tertiary)
					}
				}
			}
			.padding(.vertical, 6)
		}
	}
}
