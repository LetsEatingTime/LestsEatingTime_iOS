//
//  SignupIDVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/23.
//

import UIKit
import SnapKit
import Then

class SignupIDVC: UIViewController, UITextFieldDelegate {
    let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.backgroundColor = .clear
    }
    let idTextField = UITextField().then {
        $0.placeholder = "이름를 입력해주세요"
        $0.font = .systemFont(ofSize:14.0, weight: . medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .clear
    }
    let line = UIView().then {
        $0.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        idTextField.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func setup() {
        [
            idLabel,
            idTextField,
            line
        ].forEach{ self.view.addSubview($0) }
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(idLabel.snp.top).offset(50)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-430)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(idTextField.snp.top).offset(30)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-463)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(1)
            $0.bottom.equalTo(line.snp.top).offset(0.7)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-463)
        }
    }
}
extension SignupIDVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch (textField.text, textField.text!.count, range.length, range.location) {
        case let (text, count, 0, location) where count >= 4 && location < 4:
            line.backgroundColor = .red
            idTextField.textColor = .red
            return false
        default:
            return true
        }
        }
}
