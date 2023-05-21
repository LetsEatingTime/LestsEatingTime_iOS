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
    var ndefNFCMessage: NFCNDEFMessage?
    func gang() {
        let uuidPayload = NFCNDEFPayload.init(format: .nfcWellKnown, type: Data([0x55]), identifier: Data(), payload: UUID().uuidString.data(using: .utf8)!)
        let uuidMessage = NFCNDEFMessage(records: [uuidPayload])
        showAlert(title: "쓰기 시작합니다", message: "시작합니다")
        print("write시작한디??")
        writeNDEF(uuidMessage) { error in
            if error != nil {
                print("Error writing UUID to tag: \(error!.localizedDescription)")
                showAlert(title: "실패다 임마ㅋ", message: "ㅠㅠ")
            } else {
                showAlert(title: "성공이다 임마ㅋ 수고했다", message: "성공이다ㅎㅎ")
                print("됐다 시불")
            }
        }
    }
    var readerSession: NFCNDEFReaderSession?
    var resultPayload: Array<NFCNDEFPayload> = []
    let studentShowMealsVC = StudentShowMealsVC()
    var studentShowMealsView: UIView {
        self.studentShowMealsVC.view
    }
    let scrollView = UIScrollView()
    var contentView = UIView()
    let studentIDCard = UIImageView().then {
        $0.image = UIImage(named: "studentIDCard")
    }
//    let mealslabel = UILabel().then {
//        $0.text = "급식이 없습니다"
//        $0.
//    }
    let mealsButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(didPressMealsButton), for: .touchUpInside)
    }
    let infomationChangeButton = UIButton().then {
        $0.backgroundColor = .gray
        $0.setTitle("정보 수정", for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didPressInfomationChangeButton), for: .touchUpInside)
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
    @objc func didPressInfomationChangeButton() {
        gang()
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
extension StudentIDCardVC {
    func setup() {
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        contentView.backgroundColor = .clear
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1000))
        scrollView.addSubview(contentView)
        contentView.addSubview(studentIDCard)
        studentIDCard.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(30)
            $0.width.equalTo(400)
            $0.bottom.equalTo(studentIDCard.snp.top).offset(547)
        }
        [
//            mealsImage,
//            mealsLabel,
            mealsView,
            mealsButton,
            infomationChangeButton,
            logoutButton,
            withdrawalButton
        ].forEach { self.contentView.addSubview($0) }
        mealsButton.snp.makeConstraints {
            $0.top.equalTo(studentIDCard.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsButton.snp.top).offset(120)
        }
        infomationChangeButton.snp.makeConstraints {
            $0.top.equalTo(mealsButton.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(infomationChangeButton.snp.top).offset(50)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(infomationChangeButton.snp.bottom).offset(20)
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
        mealsView.snp.makeConstraints {
            $0.top.equalTo(studentIDCard.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(mealsView.snp.top).offset(120)
        }
        [
            scrollView
        ].forEach { self.view.addSubview($0) }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
extension StudentIDCardVC: NFCNDEFTag {
    var isAvailable: Bool { //태그가 연결되어 있고 NDEF를 지원하는지 확인
        return true
    }
    // Query the NDEF status of the tag
    func queryNDEFStatus(completionHandler: @escaping (NFCNDEFStatus, Int, Error?) -> Void) {  //태그의 NDEF 상태를 쿼리하는 자체 로직을 구현
        completionHandler(.readWrite, 1024, nil)//.readWrite 상태 및 1024 용량을 반환하는 코드
    }
    // Read the NDEF message from the tag
    func readNDEF(completionHandler: @escaping (NFCNDEFMessage?, Error?) -> Void) {  //UUID를 페이로드로 사용하여 사용자 지정 NDEF 메시지를 생성하는 코드
        completionHandler(ndefNFCMessage, nil)
        print("UUIDSuccess")
    }
    func writeNDEF(_ ndefMessage: NFCNDEFMessage, completionHandler: @escaping (Error?) -> Void) { //NDEF 메시지를 쓰는 고유 로직
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(nil)
        }
    }
    func writeLock(completionHandler: @escaping (Error?) -> Void) {//쓰기할때 tag 잠그는 코드
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(nil)
        }
    }
    static var supportsSecureCoding: Bool { // tag가 보안코딩을 지원하는가?
        return false
    }
    func copy(with zone: NSZone? = nil) -> Any { //tag 복사본
        let copy = StudentIDCardVC()
        return copy
    }
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC session did invalidate with error: \(error.localizedDescription)")
    }
    private func tagRemovalDetect(_ tag: NFCNDEFTag) {
        self.readerSession?.connect(to: tag) { (error: Error?) in
            if error != nil || !tag.isAvailable {
                os_log("Restart polling")
                self.readerSession?.restartPolling()
                return
            }
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .milliseconds(500), execute: {
                self.tagRemovalDetect(tag)
            })
        }
    }
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        print("readerSession:didDetect")
        if tags.count > 1 {
            session.alertMessage = "태그가 두개 이상 발견되었습니다. 태그 하나만 표시해주세요."
            self.tagRemovalDetect(tags.first!)
        } else {
            guard let tag = tags.first else { return }
            session.connect(to: tag ) { (error: Error?) in
                if error != nil {
                    session.restartPolling()
                    return
                }
                tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in
                    if error != nil {
                        session.invalidate(errorMessage: "NDEF 상태를 확인하지 못 했습니다. 다시 시도해주세요.")
                        return
                    }
                    
                    if status == .readOnly {
                        session.invalidate(errorMessage: "태그를 쓸 수 없습니다.")
                    } else if status == .readWrite {
                        if self.ndefNFCMessage!.length > capacity {
                            session.invalidate(errorMessage: "태그 용량이 너무 작습니다.")
                            return
                        }
                        tag.writeNDEF(self.ndefNFCMessage!) { (error: Error?) in
                            if error != nil {
                                session.invalidate(errorMessage: "태그 업데이트에 실패했습니다. 다시 시도해주세요.")
                            } else {
                                session.alertMessage = "업데이트 성공!"
                                session.invalidate()
                            }
                        }
                    } else {
                        session.invalidate(errorMessage: "태그가 NDEF 형식이 아닙니다.")
                    }
                }
            }
        }
    }
    
}
