
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
        $0.backgroundColor = .white
    }
    let progressView = UIProgressView().then {
        $0.progress = 0.25
        $0.trackTintColor = .mainColor
        $0.progressTintColor = .lightGray
    }
    let signupNextButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("다음-->", for: .normal)
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didTabsignupNextButton), for: .touchUpInside)
    }
    let eatingFoodImage = UIImageView().then {
        $0.image = UIImage(named: "EatingFoodImage")
    }
    let idVC = SignupIDVC()
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
    @objc func didTabsignupNextButton() {
        switch children.first {
        case idVC:
            addChild(pwVC)
            self.uiView.addSubview(myPWView)
            idVC.removeFromParent()
            myIDView.removeFromSuperview()
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.5, animated: true)
            }
        case pwVC:
            addChild(nameVC)
            self.uiView.addSubview(myNameView)
            pwVC.removeFromParent()
            myPWView.removeFromSuperview()
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(0.75, animated: true)
            }
        case nameVC:
            addChild(studentNumberVC)
            self.uiView.addSubview(myStudentNumberView)
            nameVC.removeFromParent()
            myNameView.removeFromSuperview()
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress(1, animated: true)
            }
        case studentNumberVC:
            sendInfomationToServer()
        default:
            print("The view is in an unrecognized view controller.")
        }
    }
    
    func configureUIView() {
        self.addChild(idVC)
        self.uiView.addSubview(myIDView)
    }
    func setup() {
        [
            eatingFoodImage,
            logo,
            uiView,
            progressView,
            signupNextButton
        ].forEach{ self.view.addSubview($0) }
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-150)
            $0.bottom.equalTo(logo.snp.top).offset(100)
            $0.left.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-70)
        }
        uiView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.bottom.equalTo(uiView.snp.top).offset(200)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        signupNextButton.snp.makeConstraints {
            $0.top.equalTo(signupNextButton.snp.bottom).offset(-50)
            $0.bottom.equalToSuperview().offset(-47)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
        }
        progressView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(-5)
            $0.bottom.equalTo(signupNextButton.snp.top).offset(-10)
            $0.left.equalToSuperview().offset(45)
            $0.right.equalToSuperview().offset(-45)
        }
        eatingFoodImage.snp.makeConstraints {
            $0.top.equalTo(eatingFoodImage.snp.bottom).offset(-367)
            $0.bottom.equalToSuperview().offset(-125)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(20)
        }
    }
}
extension SignupVC {
    func sendInfomationToServer() {
        let id = idVC.idTextField.text!
        let pw = pwVC.pwTextField.text!
        let name = nameVC.nameTextField.text!
        let studentNumber = studentNumberVC.studentNumberTextField.text!
        print(id, pw, name, studentNumber)
//        AF.request("\(api)/user/signup.do",
//                   method: .post,
//                   parameters: ["id": id,
//                                "pw": pw,
//                                "name": name,
//                                "studentNumber": studentNumber],
//                   encoding : JSONEncoding.default,
//                   headers: ["Content-Type": "application/json"]
//        )
//        .validate()
//        .responseData { response in
//            switch response.result {
//            case.success:
                self.dismiss(animated: true)
//            case.failure(let error):
//                print("통신 오류!\nCode:\(error._code), Message: \(error.errorDescription!)")
//            }
//        }
    }
}
