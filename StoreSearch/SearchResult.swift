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
	
	init(name: String, artistName: String) {
		self.name = name
		self.artistName = artistName
	}
	
	init(name: String) {
		self.name = name
		self.artistName = ""
	}
}