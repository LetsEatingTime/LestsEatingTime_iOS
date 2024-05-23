//
//  RegisterUserInfo.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/08/18.
//

import Foundation

struct RegisterUserInfo: Codable {
    let id: String
}

enum UserInfo {
    case id
}

class RegisterUserInfoManager {
    static func save(_ Id: UserInfo, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: Id))
    }
    
    static func get(_ Id: UserInfo) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: Id))
    }
    
    static func remove(_ Id: UserInfo) {
        UserDefaults.standard.removeObject(forKey: String(describing: Id))
    }
}
