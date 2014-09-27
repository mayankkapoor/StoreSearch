//
//  ViewController.swift
//  StoreSearch
//
//  Created by Mayank Kapoor on 8/24/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
                            
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	let SearchResultCellIdentifier = "SearchResultCell"
	let LoadingCellIdentifier = "LoadingCell"

	var searchResults: [SearchResult]?
	var isLoading: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var cellNib = UINib(nibName: SearchResultCellIdentifier, bundle: nil)
		self.tableView.registerNib(cellNib, forCellReuseIdentifier: SearchResultCellIdentifier)
		cellNib = UINib(nibName: LoadingCellIdentifier, bundle: nil)
		self.tableView.registerNib(cellNib, forCellReuseIdentifier: LoadingCellIdentifier)
		self.tableView.rowHeight = 80
		self.searchBar.becomeFirstResponder()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (isLoading) {
			return 1
		} else {
			if let unwrappedResults = searchResults {
				if unwrappedResults.count == 0 {
					return 1
				} else {
					return unwrappedResults.count
				}
			} else {
				return 0
			}
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if (isLoading) {
			return tableView.dequeueReusableCellWithIdentifier(LoadingCellIdentifier) as UITableViewCell
		} else {
			var cell = tableView.dequeueReusableCellWithIdentifier(SearchResultCellIdentifier) as SearchResultCell
			if let unwrappedResults = searchResults {
				if unwrappedResults.count == 0 {
					cell.nameLabel.text = "No results found"
					cell.artistNameLabel.text = ""
				} else {
					cell.nameLabel.text = unwrappedResults[indexPath.row].name!
					cell.artistNameLabel.text = "\(unwrappedResults[indexPath.row].artistName!) (\(unwrappedResults[indexPath.row].kind!))"
				}
			}
			return cell
		}
	}
	
// MARK: UISearchBarDelegate
	
	func showNetworkError() {
		let alertView = UIAlertView(title: "Whoops", message: "There was an error reading from the iTunes Store. Please try again.", delegate: nil, cancelButtonTitle: "OK")
		alertView.show()
	}
	
	func parseTrack(result: JSON) -> SearchResult {
		let name = result["trackName"].stringValue!
		let artistName = result["artistName"].stringValue!
		let artworkURL60 = result["artworkUrl60"].stringValue!
		let artworkURL100 = result["artworkUrl100"].stringValue!
		let storeURL = result["trackViewUrl"].stringValue!
		let kind = result["kind"].stringValue!
		let price = result["trackPrice"].doubleValue!
		let currency = result["currency"].stringValue!
		let genre = result["primaryGenreName"].stringValue!
		let searchResult = SearchResult(name: name, artistName: artistName, artworkURL60: artworkURL60, artworkURL100: artworkURL100, storeURL: storeURL, kind: kind, price: price, currency: currency, genre: genre)
		return searchResult
	}
	
	func parseJSON(jsonResponse: JSON) {
		if let resultCount = jsonResponse["resultCount"].integerValue {
			// TODO: Complete parseJSON
			if let results = jsonResponse["results"].arrayValue {
				for result in results {
//					println(result)
					if result["wrapperType"].stringValue == "track" {
						let searchResult: SearchResult = parseTrack(result)
						searchResults?.append(searchResult)
					}
				}
			}
		} else {
			println("Error getting resultCount")
		}
	}
	
	func performStoreRequestWithString(searchString: String) {
		let urlString = "http://itunes.apple.com/search"
		let URL: NSURL = NSURL(string: urlString)
		let params = ["term": searchString]
		var jsonResponse: JSON?
		Alamofire.request(Alamofire.Method.GET, URL, parameters: params, encoding: Alamofire.ParameterEncoding.URL)
		.responseJSON{ (request, response, jsonData, error) in // This response call is asynchronous
//			println(request)
//			println(response)
//			println(jsonData)
			if let unwrappedJSON: AnyObject = jsonData {
				jsonResponse = JSON(object: unwrappedJSON)
			}
			// Save data into searchResults and reload tableView.
			if let unwrappedJSON = jsonResponse {
				self.parseJSON(unwrappedJSON)
			} else {
				self.showNetworkError()
			}
			// Refresh tableView after savings search Results.
			self.isLoading = false
			self.tableView.reloadData()
		}
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
//		println("You searched for \(searchBar.text)")
		searchBar.resignFirstResponder()
		
		isLoading = true // Set isLoading to true before searching iTunes store
		self.tableView.reloadData()
		
		searchResults = []
		performStoreRequestWithString(searchBar.text) // Get results from Itunes server
		
		isLoading = false
		self.tableView.reloadData()
	}

// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	func tableView(tableView: UITableView!, willSelectRowAtIndexPath indexPath: NSIndexPath!) -> NSIndexPath! {
		if searchResults?.count == 0 || isLoading {
			return nil
		} else {
			return indexPath
		}
	}
}

