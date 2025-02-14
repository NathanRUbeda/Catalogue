//
//  BreedLabel.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 05/02/25.
//

import SwiftUI

/// Displays a label for the breed, containing an image, a name, a favorite button and a short description.
struct BreedLabel<Breed: DisplayableBreed, ImageView: View>: View {
	// MARK: Injected properties
	/// The cat breed to display.
	let breed: Breed
	
	/// Whether or not the cat breed is favorited.
	let isFavorited: Bool
	
	/// A closure envoked by the user to toggle the favorites for this cat breed.
	let toggleFavorited: () -> Void
	
	/// The cat breed image view to display.
	let imageView: ImageView
	
	var body: some View {
		VStack {
			HStack {
				BreedImageContainerView(width: 150, height: 130, cornerRadius: 16, imageView: self.imageView)
					.padding(.trailing, 6)
				
				VStack(alignment: .leading) {
					HStack {
						self.nameText
						
						Spacer()
						
						self.toggleFavoriteButton
					}
					
					self.descriptionText
				}
			}
			.padding(.vertical)
			
			Divider()
		}
	}
	
	/// Displays a text with the name of the cat breed.
	private var nameText: some View {
		Text(self.breed.name)
			.font(.title3)
			.fontWeight(.bold)
			.foregroundStyle(.secondary)
	}
	
	/// Displays a button that toggles favorites, labeled as a heart.
	private var toggleFavoriteButton: some View {
		Button {
			self.toggleFavorited()
		} label: {
			Image(systemName: self.isFavorited ? "heart.fill" : "heart")
				.font(.title3)
				.fontWeight(.bold)
				.frame(width: 40, height: 40)
				.foregroundStyle(.secondary)
		}
		.buttonStyle(.plain)
		.accessibilityIdentifier("toggleFavoriteButton")
	}
	
	/// Displays a text with the description of the cat breed.
	private var descriptionText: some View {
		Text(self.breed.description)
			.font(.headline)
			.foregroundStyle(.tertiary)
			.lineLimit(4)
	}
}
