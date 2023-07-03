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
    let pwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 30.0, weight: .bold)
    }
    let pwTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: . medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
        $0.isSecureTextEntry = true
    }
    let pwChackTextField = UITextField().then {
        $0.placeholder = "비밀번호를 확인해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: . medium)
        $0.isSecureTextEntry = true
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
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
            pwLabel,
            pwTextField,
            pwChackTextField,
            line,
            line2
        ].forEach{ self.view.addSubview($0) }
        pwLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalTo(pwLabel.snp.top).offset(50)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(pwTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        pwChackTextField.snp.makeConstraints {
            $0.top.equalTo(line.snp.top).offset(20)
            $0.bottom.equalTo(pwChackTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line2.snp.makeConstraints {
            $0.top.equalTo(pwChackTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line2.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
    }
    
}

