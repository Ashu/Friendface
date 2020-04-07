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
}
