//
//  ViewController.swift
//  StoreSearch
//
//  Created by Mayank Kapoor on 8/24/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
                            
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	var searchResults: [SearchResult]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
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
	
	func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SearchResultCell")
		if let unwrappedResults = searchResults {
			if unwrappedResults.count != 0 {
//				println("unwrappedResults[\(indexPath.row)].name = \(unwrappedResults[indexPath.row].name)")
//				println("unwrappedResults[\(indexPath.row)].artistName = \(unwrappedResults[indexPath.row].artistName)")
				cell.textLabel.text = unwrappedResults[indexPath.row].name!
				cell.detailTextLabel.text = unwrappedResults[indexPath.row].artistName!
			} else {
				cell.textLabel.text = "No results found"
				cell.detailTextLabel.text = ""
			}
		}
		return cell
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
//		println("You searched for \(searchBar.text)")
		searchBar.resignFirstResponder()
		searchResults = []
		if searchBar.text != "justin bieber" {
			for i in 0...2 {
				let searchResultText = "Fake search result \(i) for "
				let searchResult: SearchResult = SearchResult(name: searchResultText, artistName: searchBar.text)
				//			println("searchResult.name = \(searchResult.name) & searchResult.artistName = \(searchResult.artistName)")
				searchResults?.append(searchResult)
			}
		}
		tableView.reloadData()
	}

}

