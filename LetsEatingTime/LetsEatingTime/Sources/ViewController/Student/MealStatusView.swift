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
    }
    let breakfastImageView = UIImageView().then {
        $0.image = UIImage(contentsOfFile: "Breakfast")
    }
    let breakfastLabel = UILabel().then {
        $0.text = "아침"
    }
    let lunchImageView = UIImageView().then {
        $0.image = UIImage(contentsOfFile: "lunch")
    }
    let dinnerImageView = UIImageView().then {
        $0.image = UIImage(contentsOfFile: "dinner")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup() {
        [
            mealsExplanationLabel,
            breakfastImageView,
            lunchImageView,
            dinnerImageView
        ].forEach { self.addSubview($0) }
        mealsExplanationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        breakfastImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.equalToSuperview().offset(40)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        lunchImageView.snp.makeConstraints {
            $0.top.equalTo(breakfastImageView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(40)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        dinnerImageView.snp.makeConstraints {
            $0.top.equalTo(lunchImageView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(40)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
    }
}
