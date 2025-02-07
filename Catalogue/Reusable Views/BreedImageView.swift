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
	let referenceImageId: String
	
	/// The width of the image.
	let width: CGFloat
	
	/// The height of the image.
	let height: CGFloat
	
	/// The corner radius of the image.
	let cornerRadius: CGFloat
	
	var body: some View {
		AsyncImage(url: Constants.catImageURL(for: self.referenceImageId)) { phase in
			if let image = phase.image {
				image
					.resizable()
					.scaledToFill()
					.frame(width: self.width, height: self.height)
					.clipped()
					.clipShape(.rect(cornerRadius: self.cornerRadius))
					.overlay(
						RoundedRectangle(cornerRadius: self.cornerRadius)
							.stroke(.gray, lineWidth: 1)
					)
				
			} else if phase.error != nil {
				self.errorView
			} else {
				self.loadingView
			}
		}
	}
	
	/// Displays a cat icon with a rectangular stroke around it.
	private var errorView: some View {
		Image(systemName: "cat.fill")
			.resizable()
			.scaledToFill()
			.frame(width: self.width / 4)
			.padding()
			.foregroundStyle(.secondary)
			.frame(width: self.width, height: self.height)
			.clipShape(.rect(cornerRadius: self.cornerRadius))
			.overlay(
				RoundedRectangle(cornerRadius: self.cornerRadius)
					.stroke(.gray, lineWidth: 1)
			)
	}
	
	/// Displays a ProgressView with a rectangular stroke around it.
	private var loadingView: some View {
		ProgressView()
			.frame(width: self.width, height: self.height)
			.overlay(
				RoundedRectangle(cornerRadius: self.cornerRadius)
					.stroke(.gray, lineWidth: 1)
			)
	}
}
