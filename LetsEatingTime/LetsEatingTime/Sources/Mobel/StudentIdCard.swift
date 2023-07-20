//
//  StudentIdCard.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/07/02.
//

import Foundation

struct StudentIdCard: Codable {
    let status: Int
    let data: Datas
}
struct Datas: Codable {
    let user: User
    let mealTime: [String]
}

struct User: Codable {
    let idx: Int
    let image: String?
    let id: String
    let name: String
    let createTime: String
    let userType: String
    let grade: Int
    let className: Int
    let classNo: Int
    let approvedYn: String
    let withdrawedYn: String
    let withdrawedTime: String?
}
