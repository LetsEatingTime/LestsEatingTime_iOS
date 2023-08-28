//
//  Signup.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/21.
//

import UIKit
import SnapKit
import Then
import Alamofire

class SignupVC: UIViewController {
    
    let logo = UILabel().then {
        $0.text = "asdf"
        $0.font = .systemFont(ofSize: 100)
        $0.textAlignment = .center
    }
    let uiView = UIView().then {
        $0.backgroundColor = .clear
    }
    let progressView = UIProgressView().then {
        $0.progress = 0.25
        $0.trackTintColor = UIColor(named: "MainColor")
        $0.progressTintColor = .lightGray
    }
    let signupNextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("다음-->", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didPressSignupNextButton), for: .touchUpInside)
    }
    let backButton = UIButton().then {
        $0.backgroundColor = .gray
        $0.setTitle("<--돌아가기", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    let eatingFoodImage = UIImageView().then {
        $0.image = UIImage(named: "EatingFoodImage")
    }
    let idVC = SignupIdVC()
    var myIDView: UIView {
        self.idVC.view
    }
    let pwVC = SignupPWVC()
    var myPWView: UIView {
        self.pwVC.view
    }
    let nameVC = SignupNameVC()
    var myNameView: UIView {
        self.nameVC.view
    }
    let studentNumberVC = SignupStudentNumberVC()
    var myStudentNumberView: UIView {
        self.studentNumberVC.view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        configureUIView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension SignupVC {
    @objc func didPressBackButton() {
        print("didPressBackButton")
        switch children.first {
        case idVC:
            self.dismiss(animated: true)
        case pwVC:
            addChild(idVC)
            self.uiView.addSubview(myIDView)
            pwVC.removeFromParent()
            myPWView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(0.25, animated: true)
            }
        case nameVC:
            addChild(pwVC)
            self.uiView.addSubview(myPWView)
            nameVC.removeFromParent()
            myNameView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(0.5, animated: true)
            }
        case studentNumberVC:
            addChild(nameVC)
            self.uiView.addSubview(myNameView)
            studentNumberVC.removeFromParent()
            myStudentNumberView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(0.75, animated: true)
            }
        default:
            showAlert(title: "경고⚠️", message: "예기치 못한 오류 앱을 다시 실행해주세요")
        }
    }
    @objc func didPressSignupNextButton() {
        print("didPressSignupNextButton")
        switch children.first {
        case idVC:
            let id = idVC.idTextField.text!
            if isValidId(id) {
                addChild(pwVC)
                self.uiView.addSubview(myPWView)
                idVC.removeFromParent()
                myIDView.removeFromSuperview()
                UIView.animate(withDuration: 0.6) {
                    self.progressView.setProgress(0.5, animated: true)
                }
            } else {
                self.showAlert(title: "경고⚠️", message: "아이디는 다음 조건이 포함되어야 합니다. \n(8자리 이상, 영소문자)")
                
            }
        case pwVC:
            let password = pwVC.pwTextField.text!
            if isValidPassword(password) {
                addChild(nameVC)
                self.uiView.addSubview(myNameView)
                pwVC.removeFromParent()
                myPWView.removeFromSuperview()
                UIView.animate(withDuration: 0.6) {
                    self.progressView.setProgress(0.75, animated: true)
                }
            } else {
                self.showAlert(title: "경고⚠️", message: "비밀번호는 다음 조건이 포함되어야 합니다. \n(8자리 이상, 영문, 숫자, 특수문자)")
            }
        case nameVC:
            addChild(studentNumberVC)
            self.uiView.addSubview(myStudentNumberView)
            nameVC.removeFromParent()
            myNameView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(1, animated: true)
            }
        case studentNumberVC:
            studentNumber()
        default:
            showAlert(title: "경고⚠️", message: "예기치 못한 오류 앱을 다시 실행해주세요")
        }
    }
    func configureUIView() {
        addChild(idVC)
        self.uiView.addSubview(myIDView)
    }
    func setup() {
        [
            eatingFoodImage,
            logo,
            uiView,
            progressView,
            backButton,
            signupNextButton
        ].forEach { self.view.addSubview($0) }
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-150)
            $0.bottom.equalTo(logo.snp.top).offset(100)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        uiView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalTo(uiView.snp.top).offset(200)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        backButton.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(-50)
            $0.bottom.equalTo(signupNextButton.snp.top).offset(-10)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
        }
        signupNextButton.snp.makeConstraints {
            $0.top.equalTo(signupNextButton.snp.bottom).offset(-50)
            $0.bottom.equalToSuperview().offset(-47)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
        }
        progressView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(-5)
            $0.bottom.equalTo(backButton.snp.top).offset(-10)
            $0.left.equalToSuperview().offset(45)
            $0.right.equalToSuperview().offset(-45)
        }
        eatingFoodImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(210)
            $0.width.equalTo(435)
            $0.height.equalTo(367)
            $0.left.equalToSuperview().offset(0)
        }
    }
}
extension SignupVC {
    func contactToServer() {
        let idText = idVC.idTextField.text!
        let pwText = pwVC.pwTextField.text!
        let name = nameVC.nameTextField.text!
        let inputString = studentNumberVC.studentNumberTextField.text!
        let digitsOnly = inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let index1 = digitsOnly.index(digitsOnly.startIndex, offsetBy: 0)
        let index2 = digitsOnly.index(digitsOnly.startIndex, offsetBy: 1)
        let index3 = digitsOnly.index(digitsOnly.startIndex, offsetBy: 2)
        let grade = Int(String(digitsOnly[index1]))!
        let className = Int(String(digitsOnly[index2]))!
        let classNo = Int(String(digitsOnly[index3...]))!
        print("id \(idText), \npw \(pwText), \nname \(name), \ngrade \(grade) \nclassName \(className), \nclassNo \(classNo)")
        AF.request("\(api)/account/signup.do",
                   method: .post,
                   parameters: [
                    "id": idText,
                    "password": pwText,
                    "userType": "S",
                    "name": name,
                    "grade": grade,
                    "className": className,
                    "classNo": classNo
                   ],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case.success:
                self.dismiss(animated: true)
                self.showAlert(title: "성공!", message: "로그인을 완료해주세요.")

            case.failure(let error):
                self.showAlert(title: "경고⚠️", message: "네트워크 연결 상태를 확인해주세요! \n\(error.localizedDescription)")
            }
        }
    }
    func isValidId(_ id: String) -> Bool {
        let idRegex = "^[a-z0-9]*$"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegex)
        let isValid = idTest.evaluate(with: id)
        print("id: \(id) - Valid: \(isValid)")
        return isValid
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*\\W)[A-Za-z\\d\\W]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isValid = passwordTest.evaluate(with: password)
        print("Password: \(password) - Valid: \(isValid)")
        return isValid
    }
    func studentNumber() {
        let inputString = studentNumberVC.studentNumberTextField.text!
        if inputString.count == 4 {
            contactToServer()
        } else {
            self.showAlert(title: "경고⚠️", message: "학번은 4자리여야 합니다.")
            
        }
    }
}
