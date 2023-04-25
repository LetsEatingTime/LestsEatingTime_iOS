//
//  Signin.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/21.
//

import UIKit
import SnapKit
import Then
import Alamofire
import JWTDecode
import SwiftKeychainWrapper

class SigninVC: UIViewController {
    
//    let tokens = Token()
    
    let logoImage = UILabel().then {
        //        $0.image = (UIImage(named: ""))
        $0.text = "레츠이팅타임"
        $0.font = .systemFont(ofSize: 40, weight: .bold)
        $0.textAlignment = .center
    }
    let idTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .secondColor
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        $0.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        $0.layer.cornerRadius = 20
    }
    let pwTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.backgroundColor = .secondColor
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        $0.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        $0.layer.cornerRadius = 20
    }
    let signinButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("로그인", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didPressSigninBt), for: .touchUpInside)
    }
    let signupButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("회원가입", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didPressGoTosignupButton), for: .touchUpInside)
    }
    let eatingFoodImage = UIImageView().then {
        $0.image = UIImage(named: "EatingFoodImage")
    }
    
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    lazy var refreshCheckBoxButton = UIButton(type: .system).then {
        $0.setImage(uncheckedImage, for: .normal)
        $0.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension SigninVC {
    @objc func checkBoxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(checkedImage, for: .normal)
        } else {
            sender.setImage(uncheckedImage, for: .normal)
        }
    }
    @objc func didPressSigninBt() {
        let id = idTextField.text!
        let pw = pwTextField.text!
        
        print("\(id), \(pw)")
        AF.request("\(api)/api/account/login.do",
                   method: .post,
                   parameters: [
                    "id": id,
                    "password": pw
                   ],
                   encoding : JSONEncoding.default,
                   headers: ["Content-Type": "application/json"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case.success(let value):
                do {
                    self.present()
                    Token.setKeychain(Token.TokenType.grantType.rawValue, forKey: .grantType)
                    Token.setKeychain(Token.TokenType.accessToken.rawValue, forKey: .accessToken)
                    Token.setKeychain(Token.TokenType.refreshToken.rawValue, forKey: .refreshToken)
                } catch {
                    print("Failed to decode token: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "경고⚠️", message: "예기치 못한 오류 앱을 다시 실행해주세요.\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            case.failure(let error):
                let alertController = UIAlertController(title: "경고⚠️", message: "입력한 정보를 확인해주세요!\(error)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
@objc func didPressGoTosignupButton() {
    let VC = SignupVC()
    present(VC, animated: true)
}
}
extension SigninVC {
    func setup() {
        [
            eatingFoodImage,
            logoImage,
            idTextField,
            pwTextField,
            signupButton,
            signinButton,
            refreshCheckBoxButton
        ].forEach{ self.view.addSubview($0) }
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.bottom.equalTo(idTextField.snp.top).offset(-50)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(logoImage.snp.bottom).offset(100)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(130)
            $0.bottom.equalTo(logoImage.snp.bottom).offset(180)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        signinButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.bottom.equalTo(signinButton.snp.top).offset(50)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(10)
            $0.bottom.equalTo(signupButton.snp.top).offset(50)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        eatingFoodImage.snp.makeConstraints {
            $0.top.equalTo(eatingFoodImage.snp.bottom).offset(-367)
            $0.bottom.equalToSuperview().offset(47)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(20)
        }
        //        refreshCheckBoxButton.snp.makeConstraints {
        //            $0.top.equalTo(eatingFoodImage.snp.bottom).offset(-367)
        //            $0.bottom.equalToSuperview().offset(47)
        //            $0.left.equalToSuperview().offset(0)
        //            $0.right.equalToSuperview().offset(20)
        //        }
    }
    func present() {
        let VC = StudentIDCardVC()
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true)
    }
}
