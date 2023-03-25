//
//  Signin.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/22.
//

import Foundation

struct LoginData: Decodable, Hashable {
    let status: Int
    let message: String
    let data: LoginDatas
}

struct LoginDatas: Decodable, Hashable {
    let token: String
    let refrashToken: String
}
