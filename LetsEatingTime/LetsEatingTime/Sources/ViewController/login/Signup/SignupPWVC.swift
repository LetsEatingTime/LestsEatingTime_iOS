//
//  SignupPWVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/23.
//

import UIKit
import SnapKit
import Then

class SignupPWVC: UIViewController {
    let studentPWLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize:30.0, weight: .bold)
    }
    let studentPWTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize:14.0, weight: . medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
    }
    let studentPWChackTextField = UITextField().then {
        $0.placeholder = "비밀번호를 확인해주세요"
        $0.font = .systemFont(ofSize:14.0, weight: . medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
        $0.isSecureTextEntry = true
    }
    let line = UIView().then {
        $0.backgroundColor = .black
    }
    let line2 = UIView().then {
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
            studentPWLabel,
            studentPWTextField,
            studentPWChackTextField,
            line,
            line2
        ].forEach{ self.view.addSubview($0) }
        studentPWLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.bottom.equalTo(studentPWLabel.snp.top).offset(50)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-70)
        }
        studentPWTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.bottom.equalTo(studentPWTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(studentPWTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        studentPWChackTextField.snp.makeConstraints {
            $0.top.equalTo(line.snp.top).offset(20)
            $0.bottom.equalTo(studentPWChackTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line2.snp.makeConstraints {
            $0.top.equalTo(studentPWChackTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line2.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
    }
    
}
