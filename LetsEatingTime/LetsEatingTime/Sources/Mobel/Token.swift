//
//  Token.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/04/13.
//

import Foundation
import SwiftKeychainWrapper

class Token {
    enum TokenType: String, Codable {
        case grantType
        case accessToken
        case refreshToken
    }
    static func setKeychain(_ value: String, forKey keychainKey: TokenType) {
        KeychainWrapper.standard.set(value, forKey: keychainKey.rawValue)
    }
    static func getKeychainValue(forKey keychainKey: TokenType) -> String? {
        return KeychainWrapper.standard.string(forKey: keychainKey.rawValue)
    }
    static func removeKeychain(forKey keychainKey: TokenType) {
        KeychainWrapper.standard.removeObject(forKey: keychainKey.rawValue)
    }
}
