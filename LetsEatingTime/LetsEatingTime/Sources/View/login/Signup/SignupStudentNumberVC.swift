//
//  SignupStudentNumberVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/23.
//

import UIKit
import Then
import SnapKit

class SignupStudentNumberVC: UIViewController {
    let studentNumberLabel = UILabel().then {
        $0.text = "학번"
        $0.font = .systemFont(ofSize: 25.0, weight: .bold)
    }
    let exampleStudentNumberLabel = UILabel().then {
        $0.text = "예) 1120"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.textAlignment = .left
    }
    let studentNumberTextField = UITextField().then {
        $0.placeholder = "학번를 입력해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: . medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
    }
    let line = UIView().then {
        $0.backgroundColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func setup() {
        [
            studentNumberLabel,
            exampleStudentNumberLabel,
            studentNumberTextField,
            line
        ].forEach { self.view.addSubview($0) }
        studentNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(studentNumberLabel.snp.top).offset(50)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalTo(studentNumberLabel.snp.left).offset(50)
        }
        exampleStudentNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(studentNumberLabel.snp.top).offset(50)
            $0.left.equalTo(studentNumberLabel.snp.right).offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        studentNumberTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(studentNumberTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(studentNumberTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
    }
}
