//
//  Token.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/04/13.
//

import Foundation

struct Token: Decodable {
    let grantType : String
    let accessToken: String
    let refreshToken: String
}
