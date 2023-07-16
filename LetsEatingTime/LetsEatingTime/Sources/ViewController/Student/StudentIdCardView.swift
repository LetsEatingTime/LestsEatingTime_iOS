//
//  StudentIdCardView.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/30.
//

import UIKit
import Then
import SnapKit
import Alamofire

class StudentIdCardView: UIView {
    let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "StudentIdCardBackgroundImage")
    }
    let studentIdCardLabelKorean = UILabel().then {
        $0.text = "학 생 증"
        $0.font = .systemFont(ofSize: 36, weight: .semibold)
        $0.textAlignment = .center
    }
    let studentIdCardLabel = UILabel().then {
        $0.text = "Student ID Card"
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
    }
    let studentIdCardImage = UIImageView().then {
        $0.image = UIImage(named: "LeeChanHuk")
    }
    let studentIdCardNameLabel = UILabel().then {
        $0.text = "최시훈"
        $0.font = .systemFont(ofSize: 36, weight: .semibold)
        $0.textAlignment = .center
    }
    let studentIdCardGradeLabel = UILabel().then {
        $0.text = "1학년 1반 11번호"
        $0.font = .systemFont(ofSize: 30, weight: .medium)
        $0.textAlignment = .center
    }
    let label = UILabel().then {
        $0.text = "위 학생을 본교 학생으로 인정합니다"
        $0.font = .systemFont(ofSize: 11, weight: .light)
        $0.textAlignment = .center
    }
    let image = UIImageView().then {
        $0.image = UIImage(named: "DGSW")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        getStudentInfomation()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let parameter = [ "Token": TokenManager.get(.accessToken)! ]
    func getStudentInfomation() {
        AF.request("\(api)/api/card/profile",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"]
        )
        .responseDecodable(of: StudentIdCard.self) { response in
            switch response.result {
            case .success(let value):
                self.studentIdCardNameLabel.text = "\(value.studentName)"
                self.studentIdCardGradeLabel.text = "\(value.studentGrade)학년 \(value.studentClass)반 \(value.studentNumber)번호"
            case.failure(let error):
                showAlert(title: "경고⚠️ \(error._code)", message: "네트워크 연결을 확인해주세요.")
                print("\(error.localizedDescription)")
            }
        }
    }
    func setup() {
        [
            backgroundImage,
            studentIdCardLabelKorean,
            studentIdCardLabel,
            studentIdCardImage,
            studentIdCardNameLabel,
            studentIdCardGradeLabel,
            label,
            image
        ].forEach { self.addSubview($0) }
        backgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
        }
        studentIdCardLabelKorean.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
        }
        studentIdCardLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studentIdCardLabelKorean.snp.bottom).offset(2)
        }
        studentIdCardImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studentIdCardLabel.snp.bottom).offset(2)
            $0.width.equalTo(150)
            $0.height.equalTo(201)
        }
        studentIdCardNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studentIdCardImage.snp.bottom).offset(5)
        }
        studentIdCardGradeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studentIdCardNameLabel.snp.bottom).offset(18)
        }
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studentIdCardGradeLabel.snp.bottom)
        }
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(42)
        }
    }
}
