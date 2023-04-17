
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
        $0.trackTintColor = .mainColor
        $0.progressTintColor = .lightGray
    }
    let signupNextButton = UIButton().then {
        $0.backgroundColor = .mainColor
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
            print("예기치못한 오류ㅠㅠ")
        }
    }
    
    @objc func didPressSignupNextButton() {
        print("didPressSignupNextButton")
        switch children.first {
        case idVC:
            addChild(pwVC)
            self.uiView.addSubview(myPWView)
            idVC.removeFromParent()
            myIDView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(0.5, animated: true)
            }
        case pwVC:
            addChild(nameVC)
            self.uiView.addSubview(myNameView)
            pwVC.removeFromParent()
            myPWView.removeFromSuperview()
            UIView.animate(withDuration: 0.6) {
                self.progressView.setProgress(0.75, animated: true)
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
            organizeInfomation()
        default:
            print("예기치못한 오류ㅠㅠ")
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
        ].forEach{ self.view.addSubview($0) }
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
            $0.width.equalTo(435)
            $0.height.equalTo(367)
            $0.left.equalToSuperview().offset(0)
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
        }
    }
}
extension SignupVC {
    
    func gradeStringToInt(from originalString: String) -> Int? {
        if originalString.count >= 1 {
            let gradeIndex = originalString.index(originalString.startIndex, offsetBy: 0)
            let substring = originalString[gradeIndex]
            return Int(String(substring))
        }else {
            print("nil")
            return 00
        }
    }
    
    func classNameStringToInt(from originalString: String) -> Int? {
        if originalString.count >= 2 {
            let string = originalString.index(originalString.startIndex, offsetBy: 1)
            let substring = originalString[string]
            return Int(String(substring))
        }else {
            print("nil")
            return 00
        }
        
    }
    func classNoStringToInt(from originalString: String) -> Int? {
        if originalString.count >= 4 {
            let start = originalString.index(originalString.startIndex, offsetBy: 2)
            let end = originalString.index(originalString.startIndex, offsetBy: 3)
            let substring = originalString[start...end]
            return Int(substring)
        }else {
            print("nil")
            return 00
        }
    }
    
    func organizeInfomation() {
        let id = idVC.idTextField.text!
        let pw = pwVC.pwTextField.text!
        let name = nameVC.nameTextField.text!
        let studentNumber = studentNumberVC.studentNumberTextField.text!
        if id == "" || pw == "" || name == "" || studentNumber.count != 4 {
            let alertController = UIAlertController(title: "경고⚠️", message: "입력한 정보를 확인해주세요!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            contactToServer()
        }
    }
    func contactToServer() {
        let id = idVC.idTextField.text!
        let pw = pwVC.pwTextField.text!
        let name = nameVC.nameTextField.text!
        let studentNumber = studentNumberVC.studentNumberTextField.text!
        
        let grade = gradeStringToInt(from: studentNumber)!
        
        let className = classNameStringToInt(from: studentNumber)!
        
        let classNo = classNoStringToInt(from: studentNumber)!
        
        let sessionManager: Session = {
                let serverTrustPolices = ServerTrustManager(evaluators: [api: DisabledTrustEvaluator()])
                let configuration = URLSessionConfiguration.af.default
                configuration.timeoutIntervalForRequest = 100111
                return Session(configuration: configuration, serverTrustManager: serverTrustPolices)
            }()
        
        sessionManager.request("\(api)/api/account/signup.do",
                               method: .post,
                               parameters: ["id": id,
                                            "pw": pw,
                                            "name": name,
                                            "grade": grade,
                                            "className": className,
                                            "classNo": classNo],
                               encoding : JSONEncoding.default,
                               headers: ["Content-Type": "application/json"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case.success:
                self.dismiss(animated: true)
            case.failure(let error):
                print("통신 오류!\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
}
