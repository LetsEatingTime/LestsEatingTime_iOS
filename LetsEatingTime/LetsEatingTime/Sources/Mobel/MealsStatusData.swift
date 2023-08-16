//
//  MealsStatusData.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/08/11.
//

import Foundation

struct MealsStatusData: Decodable {
    let status: Int
    let data: [Datas]
}
struct Datas: Decodable {
    let idx: Int
    let userId: Int
    let cardId: Int
    let entryTime: Date?
    let status: String
    let type: String
    let info: String
}
