//
//  Token.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/04/13.
//

import Foundation

struct Token: Codable {
    let status: Int
    let data: Tokens
}
struct Tokens: Codable {
    var grantType: String
    var accessToken: String
    var refreshToken: String
}

enum TokenType {
    case grantType
    case accessToken
    case refreshToken
}
class TokenManager {
    static func save(_ tokenType: TokenType, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: tokenType))
    }
    
    static func get(_ tokenType: TokenType) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: tokenType))
    }
    
        static func remove(_ tokenType: TokenType) {
        UserDefaults.standard.removeObject(forKey: String(describing: tokenType))
    }
}
