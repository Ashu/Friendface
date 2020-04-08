//
//  ViewController.swift
//  Friendface
//
//  Created by Ashutosh Dave on 07/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    var friends = [Friend]()
	var filteredFriends = [Friend]()

	override func viewDidLoad() {
		super.viewDidLoad()
        
		let search = UISearchController(searchResultsController: nil)
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = "Find a friend"
		search.searchResultsUpdater = self
		navigationItem.searchController = search
        
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		let url = "https://www.hackingwithswift.com/samples/friendface.json"
		
		decoder.decode([Friend].self, fromUL: url) { friends in
			self.friends = friends
			self.filteredFriends = friends
			self.tableView.reloadData()
		}
	}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        
        return cell
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		filteredFriends = friends.matching(searchController.searchBar.text)
		tableView.reloadData()
	}
}

