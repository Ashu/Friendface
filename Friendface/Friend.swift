//
//  Friend.swift
//  Friendface
//
//  Created by Ashutosh Dave on 07/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import Foundation

struct Friend: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
	
	var friendList: String {
		return friends.map{ $0.name }.joined(separator: ", ")
	}
}

extension Array where Element == Friend {
	func matching(_ text: String?) -> [Friend] {
		if let text = text, text.count > 0 {
			return self.filter {
				$0.name.contains(text)
					|| $0.company.contains(text)
					|| $0.address.contains(text)
			}
		} else {
			return self
		}
	}
}
