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
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let downloadedFriends = try decoder.decode([Friend].self, from: data)
                
                DispatchQueue.main.async {
                    self.friends = downloadedFriends
					self.filteredFriends = downloadedFriends
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
	}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friends.map{ $0.name }.joined(separator: ", ")
        
        return cell
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		if let text = searchController.searchBar.text, text.count > 0 {
			filteredFriends = friends.filter {
				$0.name.contains(text)
					|| $0.company.contains(text)
					|| $0.address.contains(text)
			}
		} else {
			filteredFriends = friends
		}
		
		tableView.reloadData()
	}
}

