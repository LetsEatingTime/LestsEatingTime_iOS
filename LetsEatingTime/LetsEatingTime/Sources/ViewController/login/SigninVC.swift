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

class SigninVC: UIViewController {
    
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
        $0.addTarget(self, action: #selector(TabsigninBt), for: .touchUpInside)
    }
    let signupButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("회원가입", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didTabGoTosignupButton), for: .touchUpInside)
    }
    let eatingFoodImage = UIImageView().then {
        $0.image = UIImage(named: "EatingFoodImage")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        
    }
}
extension SigninVC {
    @objc func TabsigninBt() {
        let id = idTextField.text!
        let pw = pwTextField.text!
        print(id, pw)
        //        AF.request("\(api)/api/user/login.do",
        //                   method: .post,
        //                   parameters: [
        //                    "email": id,
        //                    "password": pw
        //                   ],
        //                   encoding : JSONEncoding.default,
        //                   headers: [
        //                    "Content-Type": "application/json"]
        //        )
        //        .validate()
        //        .responseData { response in
        //            switch response.result {
        //            case.success:
        let VC = StudentIDCardVC()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        //                guard let value = response.value else { return }
        //                guard let result = try? JSONDecoder().decode(LoginDatas.self, from: value) else { return }
        //                print("\(value)")
        //                UserDefaults.standard.set(result.token, forKey: "accessToken")
        //                let token = UserDefaults.standard.string(forKey: "accessToken")
        //                print("Token: \(String(describing: token))")
        //            case.failure(let error):
        //                print("통신 오류!\nCode:\(error._code), Message: \(error.errorDescription!)")
        //            }
        //        }
    }
    @objc func didTabGoTosignupButton() {
        let VC = SignupVC()
        present(VC, animated: true)
    }
    
    func setup() {
        [
            eatingFoodImage,
            logoImage,
            idTextField,
            pwTextField,
            pwTextField,
            signinButton,
            signupButton
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
    }
}
