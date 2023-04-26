//
//  SignupNameVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/23.
//

import UIKit
import Then
import SnapKit

class SignupNameVC: UIViewController {
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .systemFont(ofSize:30.0, weight: .bold)
    }
    let nameTextField = UITextField().then {
        $0.placeholder = "이름를 입력해주세요"
        $0.font = .systemFont(ofSize:14.0, weight: .medium)
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
            nameLabel,
            nameTextField,
            line
        ].forEach{ self.view.addSubview($0) }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top).offset(50)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-70)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(nameTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
    }
}
