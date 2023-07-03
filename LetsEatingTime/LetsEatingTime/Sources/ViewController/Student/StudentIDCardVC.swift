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
import os

class StudentIDCardVC: UIViewController {
    
    let scrollView = UIScrollView()
    
    var contentView = UIView()
    
    let studentIDCardView = StudentIdCardView().then {
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
        $0.backgroundColor = .myPinkColor
        $0.setTitle("로그아웃", for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didPressLogoutButton), for: .touchUpInside)
    }
    let withdrawalButton = UIButton().then {
        $0.backgroundColor = .myPinkColor
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
extension StudentIDCardVC {
    @objc func didPressMealsButton() {
        let VC = StudentShowMealsVC()
        present(VC, animated: true, completion: nil)
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
        let VC = StudentShowMealsVC()
        present(VC, animated: true, completion: nil)
    }
}
//MARK: - SetupUI
extension StudentIDCardVC {
    func setup() {
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        contentView.backgroundColor = .clear
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1000))
        scrollView.addSubview(contentView)
        contentView.addSubview(studentIDCardView)
        studentIDCardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(329)
            $0.height.equalTo(488)
        }
        [
            mealsView,
            mealsButton,
            mealsStatusView,
            logoutButton,
            withdrawalButton
        ].forEach { self.contentView.addSubview($0) }
        mealsView.snp.makeConstraints {
            $0.top.equalTo(studentIDCardView.snp.bottom).offset(70)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsView.snp.top).offset(120)
        }
        mealsButton.snp.makeConstraints {
            $0.top.equalTo(studentIDCardView.snp.bottom).offset(70)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsButton.snp.top).offset(120)
        }
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(withdrawalButton.snp.top).offset(50)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(mealsStatusView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(logoutButton.snp.top).offset(50)
        }
        mealsStatusView.snp.makeConstraints {
            $0.top.equalTo(mealsView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsStatusView.snp.top).offset(200)
        }
        [
            scrollView
        ].forEach {
            self.view.addSubview($0) }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
