//
//  StudentShowMealsView.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/29.
//

import UIKit
import SnapKit
import Then
import Alamofire

class StudentShowMealsVC: UIViewController {
    let dateLabel = UILabel().then {
        $0.text = "2023년 04월 06일"
        $0.layer.cornerRadius = 20
    }
    let breakfast = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    }
    let breakfastImage = UIImageView().then {
        $0.image = UIImage(named: "Breakfast")
    }
    let breakfastLabel = UILabel().then {
        $0.text = "아침급식이 없습니다 아침급식이 없습니다 아침급식이 없습니다 아침급식이 없습니다"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
    }
    let lunch = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    }
    let lunchImage = UIImageView().then {
        $0.image = UIImage(named: "Lunch")
    }
    let lunchLabel = UILabel().then {
        $0.text = "점심급식이 없습니다 점심급식이 없습니다 점심급식이 없습니다 점심급식이 없습니다"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
    }
    let dinner = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    }
    let dinnerImage = UIImageView().then {
        $0.image = UIImage(named: "Dinner")
    }
    let dinnerLabel = UILabel().then {
        $0.text = "저녁급식이 없습니다 저녁급식이 없습니다 저녁급식이 없습니다 저녁급식이 없습니다"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.numberOfLines = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        getMeals()
    }
}

extension StudentShowMealsVC {
    func getMeals() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        let url = "https://dodam.b1nd.com/api/meal?year=\(year)&month=\(month)&day=\(day)"
        dateLabel.text = "\(year)년 \(month)월 \(day)일"
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case.success(let value):
                    let decoder = JSONDecoder()
                    if let decodedData = try? decoder.decode(MealsData.self, from: value).data {
                        if decodedData.breakfast != nil {
                            self.breakfastLabel.text = decodedData.breakfast
                        } else {
                            self.breakfastLabel.text = "아침이 없습니다."
                        }
                        if decodedData.breakfast != nil {
                            self.lunchLabel.text = decodedData.lunch
                        } else {
                            self.lunchLabel.text = "저녁이 없습니다."
                        }
                        if decodedData.breakfast != nil {
                            self.dinnerLabel.text = decodedData.dinner
                        } else {
                            self.dinnerLabel.text = "저녁이 없습니다."
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

extension StudentShowMealsVC {
    func setup() {
        [
            breakfast,
            lunch,
            dinner,
            breakfastImage,
            lunchImage,
            dinnerImage,
            breakfastLabel,
            lunchLabel,
            dinnerLabel
        ].forEach { self.view.addSubview($0) }
        breakfast.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(breakfast.snp.top).offset(140)
        }
        breakfastImage.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.top).offset(30)
            $0.left.equalTo(breakfast.snp.left).offset(20)
            $0.right.equalTo(breakfastImage.snp.left).offset(80)
            $0.bottom.equalTo(breakfast.snp.bottom).offset(-30)
        }
        breakfastLabel.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.top).offset(20)
            $0.left.equalTo(breakfastImage.snp.right).offset(20)
            $0.right.equalTo(breakfastLabel.snp.left).offset(160)
            $0.bottom.equalTo(breakfast.snp.bottom).offset(-20)
        }
        lunch.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(lunch.snp.top).offset(140)
        }
        lunchImage.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.top).offset(30)
            $0.left.equalTo(lunch.snp.left).offset(20)
            $0.right.equalTo(lunchImage.snp.left).offset(80)
            $0.bottom.equalTo(lunch.snp.bottom).offset(-30)
        }
        lunchLabel.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.top).offset(20)
            $0.left.equalTo(lunchImage.snp.right).offset(20)
            $0.right.equalTo(lunchLabel.snp.left).offset(160)
            $0.bottom.equalTo(lunch.snp.bottom).offset(-20)
        }
        dinner.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(dinner.snp.top).offset(140)
        }
        dinnerImage.snp.makeConstraints {
            $0.top.equalTo(dinner.snp.top).offset(30)
            $0.left.equalTo(dinner.snp.left).offset(20)
            $0.right.equalTo(dinnerImage.snp.left).offset(80)
            $0.bottom.equalTo(dinner.snp.bottom).offset(-30)
        }
        dinnerLabel.snp.makeConstraints {
            $0.top.equalTo(dinner.snp.top).offset(20)
            $0.left.equalTo(dinnerImage.snp.right).offset(20)
            $0.right.equalTo(dinnerLabel.snp.left).offset(160)
            $0.bottom.equalTo(dinner.snp.bottom).offset(-20)
        }
    }
}
