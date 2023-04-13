//
//  GetMealsAPI.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/04/06.
//

import Foundation

struct GetMealsAPI {
    let status: Int
    let data: MealsDatas
}
struct MealsDatas {
    let breakfast: String
    let lunch: String
    let dinner: String
}

