//
//  OfflineView.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import SwiftUI

/// Displays a view indicating the user has no internet.
struct OfflineView: View {
    var body: some View {
		VStack {
			Image(systemName: "wifi.slash")
				.font(.system(size: 120))
				.padding()
			
			Text("The internet connection appears to be offline.")
				.font(.body)
				.fontWeight(.semibold)
				.foregroundStyle(.secondary)
			
			Spacer()
		}
		.toolbar {
			ToolbarItem(placement: .principal) {
				Image("catalogue")
					.resizable()
					.scaledToFit()
					.frame(height: 26)
					.padding()
			}
		}
    }
}

#Preview {
    OfflineView()
}
