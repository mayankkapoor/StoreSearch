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

	var searchResults: [String] = Array(count: 3, repeatedValue: "")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}
	
	func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell") as UITableViewCell
		cell.textLabel.text = searchResults[indexPath.row]
		return cell
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
		println("You searched for \(searchBar.text)")
		for i in 0...2 {
			let searchText: String = "Fake search result \(i) for \(searchBar.text)" as String
			searchResults[i] = searchText
		}
		tableView.reloadData()
	}

}

