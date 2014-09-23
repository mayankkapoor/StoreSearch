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

	var searchResults: [SearchResult]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var cellNib = UINib(nibName: SearchResultCellIdentifier, bundle: nil)
		self.tableView.registerNib(cellNib, forCellReuseIdentifier: SearchResultCellIdentifier)
		self.tableView.rowHeight = 80
		self.searchBar.becomeFirstResponder()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier(SearchResultCellIdentifier) as SearchResultCell
		if let unwrappedResults = searchResults {
			if unwrappedResults.count == 0 {
				cell.nameLabel.text = "No results found"
				cell.artistNameLabel.text = ""
			} else {
				cell.nameLabel.text = unwrappedResults[indexPath.row].name!
				cell.artistNameLabel.text = unwrappedResults[indexPath.row].artistName!
			}
		}
		return cell
	}
	
// MARK: UISearchBarDelegate
	
	func performStoreRequestWithString(searchString: String) {
		let urlString = "http://itunes.apple.com/search"
		let URL: NSURL = NSURL(string: urlString)
		let params = ["term": searchString]
		var jsonValue: JSON?
		Alamofire.request(Alamofire.Method.GET, URL, parameters: params, encoding: Alamofire.ParameterEncoding.URL)
		.response{ (request, response, data, error) in // This response call is asynchronous, but the rest of the code is synchronous.
//			println(request)
//			println(response)
			jsonValue = JSON(data: data! as NSData)
			println(jsonValue)
		}
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
//		println("You searched for \(searchBar.text)")
		searchBar.resignFirstResponder()
		searchResults = []
		
		// Get results from Itunes server
		performStoreRequestWithString(searchBar.text)
		
		tableView.reloadData()
	}

// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	func tableView(tableView: UITableView!, willSelectRowAtIndexPath indexPath: NSIndexPath!) -> NSIndexPath! {
		if searchResults?.count == 0 {
			return nil
		} else {
			return indexPath
		}
	}
}

