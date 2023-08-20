//
//  Internal DB.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/08/18.
//

import Foundation

struct Id: Codable {
    let id: String
}

enum Identifier {
    case id
}
class GetId {
    static func save(_ Id: Identifier, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: Id))
    }
    
    static func get(_ Id: Identifier) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: Id))
    }
    
    static func remove(_ Id: Identifier) {
        UserDefaults.standard.removeObject(forKey: String(describing: Id))
    }
}
