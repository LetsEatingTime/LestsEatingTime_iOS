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
    let mealsStatusViews = UIView()
    let studentIdCardView = StudentIdCardView().then {
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 5
    }
    let mealsLabel = UILabel().then {
        $0.text = "급식이 없습니다"
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
        $0.backgroundColor = UIColor(named: "MyPinkColor")
        $0.setTitle("회원 탈퇴", for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didPressWithdrawalButton), for: .touchUpInside)
    }
    let mealsView = UIView().then {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 20
    }
    let mealsStatusView = UIView().then {
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 15
    }
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        print("didPressWithdrawalButton")
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
            mealsLabel,
            mealsButton,
            mealsStatusView,
            logoutButton,
            withdrawalButton
        ].forEach { self.contentView.addSubview($0) }
        mealsView.snp.makeConstraints {
            $0.top.equalTo(studentIdCardView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsView.snp.top).offset(120)
        }
        mealsLabel.snp.makeConstraints {
            $0.centerY.equalTo(mealsView)
            $0.left.equalTo(mealsView).offset(40)
            $0.right.equalTo(mealsView).offset(-20)
        }
        mealsButton.snp.makeConstraints {
            $0.top.equalTo(studentIdCardView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsButton.snp.top).offset(120)
        }
        mealsStatusView.addSubview(mealsStatusViews)
        mealsStatusViews.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
