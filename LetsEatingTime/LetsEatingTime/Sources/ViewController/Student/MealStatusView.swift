//
//  MealsStatusView.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/07/16.
//

import UIKit
import Then
import SnapKit
import Alamofire

class MealsStatusView: UIView {
    
    let mealsExplanationLabel = UILabel().then {
        $0.text = "나의 급식 현황"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textAlignment = .center
    }
    let mealsDate = UILabel().then {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        $0.text = "\(year)년\(month)월\(day)일"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textAlignment = .center
    }
    let breakfast = UILabel().then {
        $0.text = "아침"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    let breakfastImage = UIImageView().then {
        $0.image = UIImage(named: "Breakfast")
    }
    let breakfastCKView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 5
    }
    
    let lunch = UILabel().then {
        $0.text = "점심"
        $0.font = .systemFont(ofSize: 15, weight: .medium)

    }
    let lunchImage = UIImageView().then {
        $0.image = UIImage(named: "Lunch")
    }
    let lunchCKView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 5
    }
    let dinner = UILabel().then {
        $0.text = "저녁"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    let dinnerImage = UIImageView().then {
        $0.image = UIImage(named: "Dinner")
    }
    let dinnerCKView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 5

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup() {
        [
            mealsExplanationLabel,
            mealsDate,
            breakfastImage,
            breakfast,
            breakfastCKView,
            lunchImage,
            lunch,
            lunchCKView,
            dinnerImage,
            dinner,
            dinnerCKView
        ].forEach { self.addSubview($0) }
        mealsExplanationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        mealsDate.snp.makeConstraints {
            $0.top.equalTo(mealsExplanationLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        breakfast.snp.makeConstraints {
            $0.centerY.equalTo(breakfastImage)
            $0.left.equalTo(breakfastImage.snp.right).offset(8)
        }
        breakfastImage.snp.makeConstraints {
            $0.top.equalTo(mealsDate.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(70)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        breakfastCKView.snp.makeConstraints {
            $0.centerY.equalTo(breakfastImage)
            $0.right.equalToSuperview().offset(-70)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        lunch.snp.makeConstraints {
            $0.centerY.equalTo(lunchImage)
            $0.left.equalTo(lunchImage.snp.right).offset(8)
        }
        lunchImage.snp.makeConstraints {
            $0.top.equalTo(breakfastImage.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(70)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        lunchCKView.snp.makeConstraints {
            $0.centerY.equalTo(lunchImage)
            $0.right.equalToSuperview().offset(-70)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        dinner.snp.makeConstraints {
            $0.centerY.equalTo(dinnerImage)
            $0.left.equalTo(dinnerImage.snp.right).offset(8)
        }
        dinnerImage.snp.makeConstraints {
            $0.top.equalTo(lunchImage.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(70)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        dinnerCKView.snp.makeConstraints {
            $0.centerY.equalTo(dinnerImage)
            $0.right.equalToSuperview().offset(-70)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
    }
}
