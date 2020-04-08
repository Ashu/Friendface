//
//  ViewController.swift
//  Friendface
//
//  Created by Ashutosh Dave on 07/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	let dataSource = FriendDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
    
		dataSource.dataChanged = { [weak self] in
			self?.tableView.reloadData()
		}
		
		dataSource.fetch("https://www.hackingwithswift.com/samples/friendface.json")
		tableView.dataSource = dataSource
		
		let search = UISearchController(searchResultsController: nil)
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = "Find a friend"
		search.searchResultsUpdater = dataSource
		navigationItem.searchController = search
        
	}
}

