//
//  BreedImageView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 04/02/25.
//

import SwiftUI

/// Displays an AsyncImage to show the breed's image or a default icon when missing a photo.
struct BreedImageView: View {
	// MARK: Injected properties
	/// The image id for the cat breed.
	let referenceImageId: String?
	
	// MARK: Local properties
	/// If the image is done loading or not.
	@State private var isLoading = true
	
	/// The image loading error.
	@State private var error: Error?
	
	/// The cat breed image view to display.
	@State private var image: Image?
	
	var body: some View {
		self.contentView
			.task {
				defer {
					self.isLoading = false
				}
				
				if let referenceImageId, let url = Constants.catImageURL(for: referenceImageId) {
					do {
						let (data, _) = try await URLSession.shared.data(from: url)
						if let uiImage = UIImage(data: data) {
							self.image = Image(uiImage: uiImage)
						}
					} catch {
						self.error = error
					}
				}
			}
	}
	
	/// Displays content depending on the result of the image fetching.
	@ViewBuilder
	private var contentView: some View {
		if let image {
			image
				.resizable()
				.scaledToFill()
		} else if self.isLoading {
			self.loadingView
		} else {
			self.errorView
		}
	}
	
	/// Displays a cat icon with a rectangular stroke around it.
	private var errorView: some View {
		Image(systemName: "cat.fill")
			.resizable()
			.padding()
			.foregroundStyle(.secondary)
	}
	
	/// Displays a ProgressView with a rectangular stroke around it.
	private var loadingView: some View {
		ProgressView()
			.controlSize(.large)
	}
}
