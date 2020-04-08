//
//  JSONDecoder-Remote.swift
//  Friendface
//
//  Created by Ashutosh Dave on 08/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import Foundation

extension JSONDecoder {
	func decode<T: Decodable>(_ type: T.Type, fromUL url: String, completion: @escaping (T) -> Void) {
		guard let url = URL(string: url) else {
			fatalError("Invalid ULR passed.")
		}
		
		DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
				let downloadedData = try self.decode(type, from: data)
                
                DispatchQueue.main.async {
					completion(downloadedData)
				}
            } catch {
                print(error.localizedDescription)
            }
        }
	}
}
