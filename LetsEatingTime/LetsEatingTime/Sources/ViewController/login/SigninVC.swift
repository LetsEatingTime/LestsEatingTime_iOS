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
        $0.backgroundColor = UIColor(named: "SecondColor")
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.layer.cornerRadius = 20
    }
    let pwTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.backgroundColor = UIColor(named: "SecondColor")
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.layer.cornerRadius = 20
    }
    let signinButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("로그인", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didPressSigninBt), for: .touchUpInside)
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
    let findId = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(didTabfindId), for: .touchUpInside)
    }
    let findView = UIView().then {
        $0.backgroundColor = .black
    }
    let findPW = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(didTabfindPW), for: .touchUpInside)
    }
    let findView2 = UIView().then {
        $0.backgroundColor = .black
    }
    let signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(didPressGoTosignupButton), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
//        chackToken()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension SigninVC {
    @objc func didTabfindId() {
        self.showAlert(title: "2-2반", message: "최시훈한테 찾아오시면 알려드립니다.")
    }
    @objc func didTabfindPW() {
        self.showAlert(title: "2-2반", message: "최시훈한테 찾아오시면 알려드립니다.")
    }
    @objc func checkBoxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(checkedImage, for: .normal)
        } else {
            sender.setImage(uncheckedImage, for: .normal)
        }
    }
    func enterTestData() {
        idTextField.text = "tank6974"
        pwTextField.text = "bksa2354!@"
    }
    @objc func didPressSigninBt() {
        enterTestData()
        let idText = idTextField.text!
        let pwText = pwTextField.text!
        print("\(idText), \(pwText)")
        AF.request("\(api)/account/login.do",
                   method: .post,
                   parameters: [
                    "id": idText,
                    "password": pwText
                   ],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"]
        )
        .validate()
        .responseDecodable(of: Token.self) { response in
            switch response.result {
            case.success(let value):
                GetId.save(.id, idText)
                TokenManager.save(.grantType, value.data.grantType)
                    TokenManager.save(.refreshToken, value.data.refreshToken)
                    TokenManager.save(.accessToken, value.data.accessToken)
                    self.present()
            case.failure(let error):
//                    showAlert(title: "경고⚠️ \(error._code)", message: "\(error.localizedDescription)")
                    print(error.localizedDescription)
                }
        }
    }
    @objc func didPressGoTosignupButton() {
        let viewController = SignupVC()
        present(viewController, animated: true)
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
extension SigninVC {
    func setup() {
        [
            eatingFoodImage,
            logoImage,
            idTextField,
            pwTextField,
            signinButton,
            findId,
            findView,
            findPW,
            findView2,
            signupButton
        ].forEach { self.view.addSubview($0) }
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
        eatingFoodImage.snp.makeConstraints {
            $0.top.equalTo(eatingFoodImage.snp.bottom).offset(-367)
            $0.bottom.equalToSuperview().offset(47)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(20)
        }
        findId.snp.makeConstraints {
            $0.right.equalTo(findPW.snp.left).offset(-20)
            $0.top.equalTo(signinButton.snp.bottom).offset(20)
        }
        findView.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(22)
            $0.left.equalTo(findPW.snp.left).offset(-10)
            $0.width.equalTo(1)
            $0.height.equalTo(20)
        }
        findPW.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signinButton.snp.bottom).offset(20)
        }
        findView2.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(22)
            $0.left.equalTo(findPW.snp.right).offset(10)
            $0.width.equalTo(1)
            $0.height.equalTo(20)
        }
        signupButton.snp.makeConstraints {
            $0.left.equalTo(findPW.snp.right).offset(20)
            $0.top.equalTo(signinButton.snp.bottom).offset(20)
        }
        //        refreshCheckBoxButton.snp.makeConstraints {
        //            $0.top.equalTo(eatingFoodImage.snp.bottom).offset(-367)
        //            $0.bottom.equalToSuperview().offset(47)
        //            $0.left.equalToSuperview().offset(0)
        //            $0.right.equalToSuperview().offset(20)
        //        }
    }
    func present() {
        let viewController = StudentIdCardVC()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    func chackToken() {
                AF.request("\(api)/account/login.do",
                   method: .post,
                   headers: ["Authorization": "\(TokenManager.get(.grantType)!) \(TokenManager.get(.accessToken)!)"]
        )
        .validate()
        .responseDecodable(of: Token.self) { response in
            switch response.result {
            case.success(let value):
                print("\(value.data.accessToken)\(value.data.refreshToken)")
                TokenManager.save(.accessToken, value.data.accessToken)
                TokenManager.save(.refreshToken, value.data.refreshToken)
                self.present()
            case .failure(let error):
                print("로그인 다시하셈 ㅅㄱ\(error._code) \(error.localizedDescription)")

            }
        }
    }
}
