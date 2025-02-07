//
//  NetworkMonitor.swift
//  Catalogue
//
//  Created by Nathan Ryan Ubeda on 06/02/25.
//

import Foundation
import Network

/// An object that checks for any changes in network connectivity.
@Observable
class NetworkMonitor: ObservableObject {
	/// A network monitor.
	private let networkMonitor = NWPathMonitor()
	
	/// The queue to monitor network changes on.
	private let queue = DispatchQueue(label: "Monitor")
	
	/// Whether or not the device is connected to the internet.
	var isConnected = false
	
	/// Designated initializer.
	init() {
		self.networkMonitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
		}
		self.networkMonitor.start(queue: self.queue)
	}
}
