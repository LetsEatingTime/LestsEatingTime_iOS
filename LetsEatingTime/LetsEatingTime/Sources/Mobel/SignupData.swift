//
//  SignupData.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/04/18.
//

import Foundation

struct SignupData: Decodable, Hashable {
    let status: Int
    let message: String
    let data: SignupDatas
}

struct SignupDatas: Decodable, Hashable {
    let token: String
}
