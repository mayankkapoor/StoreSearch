//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Mayank Kapoor on 8/29/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation

class SearchResult: NSObject {
	var name: String?
	var artistName: String?
	var artworkURL60: String?
	var artworkURL100: String?
	var storeURL: String?
	var kind: String?
	var currency: String?
	var price = 0.00
	var genre: String?
	
	init(name: String, artistName: String) {
		self.name = name
		self.artistName = artistName
	}
	
	init(name: String) {
		self.name = name
		self.artistName = ""
	}
	
	init(name: String, artistName: String, artworkURL60: String, artworkURL100: String, storeURL: String, kind: String, price: Double, currency: String, genre: String) {
		self.name = name
		self.artistName = artistName
		self.artworkURL60 = artworkURL60
		self.artworkURL100 = artworkURL100
		self.storeURL = storeURL
		self.kind = kind
		self.price = price
		self.genre = genre
	}
}