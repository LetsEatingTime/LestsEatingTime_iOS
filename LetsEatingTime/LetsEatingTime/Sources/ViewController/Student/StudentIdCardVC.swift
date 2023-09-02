//
//  StudentIDCardVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/22.
//

import UIKit
import SnapKit
import Then
import Alamofire
import CoreNFC

class StudentIdCardVC: UIViewController {
    
    let scrollView = UIScrollView()
    
    var contentView = UIView()
    
    let mealsStatusView = MealsStatusView()
    
    let grantType = TokenManager.get(.grantType)!
    let accessToken = TokenManager.get(.accessToken)!
    
    let studentIdCardView = StudentIdCardView().then {
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 5
    }
    
    let mealsImage = UIImageView().then {
        $0.image = UIImage(named: "Lunch")
    }
    
    let mealsLabel = UILabel().then {
        $0.text = "급식이 없습니다"
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.numberOfLines = 0
    }
    
    let mealsButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(didPressMealsButton), for: .touchUpInside)
    }
    
    let logoutButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MyPinkColor")
        $0.setTitle("로그아웃", for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didPressLogoutButton), for: .touchUpInside)
    }
    
    let withdrawalButton = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.setTitle("회원 탈퇴", for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didPressWithdrawalButton), for: .touchUpInside)
    }
    
    let mealsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    }
    
    let mealsStatusViews = MealsStatusView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    }
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getStudentInfomation()
//        getStudentMealsStatus()
        getMeals() 
    }
}
extension StudentIdCardVC {
    func getMeals() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        let url = "https://dodam.b1nd.com/api/meal?year=\(year)&month=\(month)&day=\(day)"
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case.success(let value):
                    let decoder = JSONDecoder()
                    if let decodedData = try? decoder.decode(MealsData.self, from: value).data {
                        self.mealsLabel.text = decodedData.dinner
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    func getStudentMealsStatus() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        let id = GetId.get(.id)!
        AF.request("\(api)/user/meal-entry?id=\(id)&date=\(currentDate)",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization": "\(grantType) \(accessToken)"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case.success(let value):
                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode(MealsStatusData.self, from: value).data {
                    decodedData.forEach { data in
                        print("getStudentMealsStatus: success")
                        switch data.info {
                        case "breakfast":
                            self.mealsStatusViews.breakfastCKView.backgroundColor = UIColor(named: "Succes")
                        case "lunch":
                            self.mealsStatusViews.lunchCKView.backgroundColor = UIColor(named: "Succes")
                        case "dinner":
                            self.mealsStatusViews.dinnerCKView.backgroundColor = UIColor(named: "Succes")
                        default:
                            self.showAlert(title: "에잉..❓", message: "먹은 급식이 없어요😢")
                        }
                    }
                } else {
                    self.showAlert(title: "경고⚠️", message: "예상치 못한 오류😢 오류가 지속되면 최시훈에게 찾아오세요")
                    if let data = response.data {
                                        print(String(decoding: data, as: UTF8.self))
                                    }
                }
            case.failure(_):
                print("error")
                if let data = response.data {
                    print(String(decoding: data, as: UTF8.self))
                }
            }
        }
    }
    func getStudentInfomation() {
        let decoder = JSONDecoder()
        print("\(grantType) \(accessToken)")
        AF.request("\(api)/user/profile",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization": "\(grantType) \(accessToken)"]
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'+09:00'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                if let decodedData = try? decoder.decode(StudentIdCard.self, from: value).data {
                    print("success")
                    self.studentIdCardView.studentIdCardNameLabel.text = "\(decodedData.user.name!)"
                    self.studentIdCardView.studentIdCardGradeLabel.text = "\(decodedData.user.grade!)학년 \(decodedData.user.className!)반 \(decodedData.user.classNo!)번호"
                } else {
                    print("decodingerror")
                }
            case .failure(let error):
                self.showAlert(title: "경고⚠️", message: "\(String(describing: error.errorDescription))")
                print("error")
            }
        }
    }
}
extension StudentIdCardVC {
    @objc func didPressMealsButton() {
        let VC = StudentShowMealsVC()
        self.present(VC, animated: true, completion: nil)
    }
    @objc func didPressLogoutButton() {
        let VC = SigninVC()
        VC.idTextField.text = ""
        VC.pwTextField.text = ""
        self.dismiss(animated: false)
        TokenManager.remove(.grantType)
        TokenManager.remove(.refreshToken)
        TokenManager.remove(.accessToken)
    }
    @objc func didPressWithdrawalButton() {
        AF.request("\(api)/account/login.do",
                   method: .post,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization": "\(grantType) \(accessToken)"]
        )
        .validate()
        .responseDecodable(of: Token.self) { response in
            switch response.result {
            case.success:
                self.dismiss(animated: true)
            case.failure(let error):
                self.showAlert(title: "실패⛔️", message: "회원탈퇴가 실패했어요👉👈\n\(error.localizedDescription)")
            }
        }
    }
}
//MARK: - SetupUI
extension StudentIdCardVC {
    func setup() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.backgroundColor = .clear
        contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view.bounds.width)
            $0.height.equalTo(1000)
        }
        contentView.addSubview(studentIdCardView)
        studentIdCardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(329)
            $0.height.equalTo(488)
        }
        [
            mealsView,
            mealsImage,
            mealsLabel,
            mealsButton,
            mealsStatusViews,
            logoutButton,
            withdrawalButton
        ].forEach { self.contentView.addSubview($0) }
        mealsView.snp.makeConstraints {
            $0.top.equalTo(studentIdCardView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsView.snp.top).offset(120)
        }
        mealsImage.snp.makeConstraints {
            $0.top.equalTo(mealsView.snp.top).offset(30)
            $0.left.equalTo(mealsView.snp.left).offset(20)
            $0.right.equalTo(mealsImage.snp.left).offset(80)
            $0.bottom.equalTo(mealsView.snp.bottom).offset(-30)
        }
        mealsLabel.snp.makeConstraints {
            $0.centerY.equalTo(mealsView)
            $0.left.equalTo(mealsImage.snp.right).offset(10)
            $0.right.equalTo(mealsView).offset(-20)
        }
        mealsButton.snp.makeConstraints {
            $0.top.equalTo(studentIdCardView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsButton.snp.top).offset(120)
        }
        mealsStatusViews.snp.makeConstraints {
            $0.top.equalTo(mealsView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsStatusViews.snp.top).offset(200)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(mealsStatusViews.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(logoutButton.snp.top).offset(50)
        }
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(50)
        }
//        mealsStatusViews.addSubview(mealsStatusView)
//        mealsStatusView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
}
