//
//  BreedImageContainerView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 13/02/25.
//

import SwiftUI

/// Displays a customizable cat breed image.
struct BreedImageContainerView<ImageView: View>: View {
	// MARK: Injected properties
	/// The width of the image.
	let width: CGFloat
	
	/// The height of the image.
	let height: CGFloat
	
	/// The corner radius of the image.
	let cornerRadius: CGFloat
	
	/// The cat breed image view to display.
	let imageView: ImageView
	
	var body: some View {
		self.imageView
			.frame(width: self.width, height: self.height)
			.clipped()
			.clipShape(.rect(cornerRadius: self.cornerRadius))
			.overlay(
				RoundedRectangle(cornerRadius: self.cornerRadius)
					.stroke(.gray, lineWidth: 1)
			)
	}
}
