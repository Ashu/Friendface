//
//  FriendDataSource.swift
//  Friendface
//
//  Created by Ashutosh Dave on 08/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class FriendDataSource: NSObject, UITableViewDataSource, UISearchResultsUpdating {
	var friends = [Friend]()
	var filteredFriends = [Friend]()
	var dataChanged: (() -> Void)?
	
	func fetch(_ urlString: String) {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		decoder.decode([Friend].self, fromUL: urlString) { friends in
			self.friends = friends
			self.filteredFriends = friends
			self.dataChanged?()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		   return filteredFriends.count
	   }
	   
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
	   let friend = filteredFriends[indexPath.row]
	   
	   cell.textLabel?.text = friend.name
	   cell.detailTextLabel?.text = friend.friendList
	   
	   return cell
   }
	   
   func updateSearchResults(for searchController: UISearchController) {
	   filteredFriends = friends.matching(searchController.searchBar.text)
	   self.dataChanged?()
   }
}
