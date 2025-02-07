//
//  Array+Extensions.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import Foundation

extension Array where Element == CatBreed {
	mutating func appendContentsNotAlreadyContained(contentsOf contents: [Element]) {
		var elementsToAppend: [Element] = []
		for element in contents {
			if !self.contains(where: { $0.id == element.id }) {
				elementsToAppend.append(element)
			}
		}
		self.append(contentsOf: elementsToAppend)
	}
}
