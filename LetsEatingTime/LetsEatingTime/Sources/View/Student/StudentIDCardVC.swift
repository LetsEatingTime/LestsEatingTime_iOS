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
    var session: NFCReaderSession?
    
    let uuid = UUID()

    lazy var uuidData: Data = {
        return uuid.uuidString.data(using: .utf8)!
    }()

    lazy var payload: NFCNDEFPayload = {
        return NFCNDEFPayload(format: .nfcWellKnown, type: "T".data(using: .utf8)!, identifier: Data(), payload: uuidData)
    }()

    lazy var message: NFCNDEFMessage = {
        return NFCNDEFMessage(records: [payload])
    }()

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
        print("NFCNDEFMessage: \(message)")
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
extension StudentIDCardVC: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
    }
    func gang() {
        message = message
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "폰을 태그에 가까이 가져가세요"
        session?.begin()
    }
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {}
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        var str: String = "\(message)"
        var strToUInt: [UInt8] = [UInt8](str.utf8)
        
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "하나이상의 태그가 입력 되었습니다. 다시 실행해주세요"
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        
        let tag = tags.first!
        session.connect(to: tag, completionHandler: {(error:Error?) in
            if nil != error {
                session.alertMessage = "태그 연결 실패"
                session.invalidate()
                return
            }
            tag.queryNDEFStatus(completionHandler: {(ndefStatus: NFCNDEFStatus, capacity:Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "태그의 NDEF 상태를 쿼리할 수 없습니다"
                    session.invalidate()
                    return
                }
                switch ndefStatus {
                case .notSupported:
                    session.alertMessage = "Tag is not NDEF compliant"
                    session.invalidate()
                case .readWrite:
                    tag.writeNDEF(.init(records: [.init(format: .nfcWellKnown, type: Data([06]), identifier: Data([0x0c]), payload: Data(strToUInt))]), completionHandler: { (error: Error?) in
                                    if nil != error {
                        session.alertMessage = "쓰기가 실패했습니다 \(error!)"
                    } else {
                        session.alertMessage = "쓰기 성공"
                        print("성공")
                    }
                })
                case .readOnly:
                    session.alertMessage = "Tag is readOnly"
                    session.invalidate()
                @unknown default:
                    session.alertMessage = "NDEF 태그 상태가 정의되지 않았습니다"
                    session.invalidate()
                }
            })
            
        })
    }
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }
    func readerSession(_ session: NFCReaderSession, didInvalidateWithError error:Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "Session Invalidated",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //    var isAvailable: Bool { //태그가 연결되어 있고 NDEF를 지원하는지 확인
    //        return true
    //    }
    //    // Query the NDEF status of the tag
    //    func queryNDEFStatus(completionHandler: @escaping (NFCNDEFStatus, Int, Error?) -> Void) {  //태그의 NDEF 상태를 쿼리하는 자체 로직을 구현
    //        completionHandler(.readWrite, 1024, nil)//.readWrite 상태 및 1024 용량을 반환하는 코드
    //    }
    //    // Read the NDEF message from the tag
    //    func readNDEF(completionHandler: @escaping (NFCNDEFMessage?, Error?) -> Void) {  //UUID를 페이로드로 사용하여 사용자 지정 NDEF 메시지를 생성하는 코드
    //        completionHandler(ndefNFCMessage, nil)
    //        print("UUIDSuccess")
    //    }
    //    func writeNDEF(_ ndefMessage: NFCNDEFMessage, completionHandler: @escaping (Error?) -> Void) { //NDEF 메시지를 쓰는 고유 로직
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    //            completionHandler(nil)
    //        }
    //    }
    //    func writeLock(completionHandler: @escaping (Error?) -> Void) {//쓰기할때 tag 잠그는 코드
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    //            completionHandler(nil)
    //        }
    //    }
    //    static var supportsSecureCoding: Bool { // tag가 보안코딩을 지원하는가?
    //        return false
    //    }
    //    func copy(with zone: NSZone? = nil) -> Any { //tag 복사본
    //        let copy = StudentIDCardVC()
    //        return copy
    //    }
    //    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    //        print("NFC session did invalidate with error: \(error.localizedDescription)")
    //    }
    //    private func tagRemovalDetect(_ tag: NFCNDEFTag) {
    //        self.readerSession?.connect(to: tag) { (error: Error?) in
    //            if error != nil || !tag.isAvailable {
    //                os_log("Restart polling")
    //                self.readerSession?.restartPolling()
    //                return
    //            }
    //            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .milliseconds(500), execute: {
    //                self.tagRemovalDetect(tag)
    //            })
    //        }
    //    }
    //    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
    //        print("readerSession:didDetect")
    //        if tags.count > 1 {
    //            session.alertMessage = "태그가 두개 이상 발견되었습니다. 태그 하나만 표시해주세요."
    //            self.tagRemovalDetect(tags.first!)
    //        } else {
    //            guard let tag = tags.first else { return }
    //            session.connect(to: tag ) { (error: Error?) in
    //                if error != nil {
    //                    session.restartPolling()
    //                    return
    //                }
    //                tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in
    //                    if error != nil {
    //                        session.invalidate(errorMessage: "NDEF 상태를 확인하지 못 했습니다. 다시 시도해주세요.")
    //                        return
    //                    }
    //
    //                    if status == .readOnly {
    //                        session.invalidate(errorMessage: "태그를 쓸 수 없습니다.")
    //                    } else if status == .readWrite {
    //                        if self.ndefNFCMessage!.length > capacity {
    //                            session.invalidate(errorMessage: "태그 용량이 너무 작습니다.")
    //                            return
    //                        }
    //                        tag.writeNDEF(self.ndefNFCMessage!) { (error: Error?) in
    //                            if error != nil {
    //                                session.invalidate(errorMessage: "태그 업데이트에 실패했습니다. 다시 시도해주세요.")
    //                            } else {
    //                                session.alertMessage = "업데이트 성공!"
    //                                session.invalidate()
    //                            }
    //                        }
    //                    } else {
    //                        session.invalidate(errorMessage: "태그가 NDEF 형식이 아닙니다.")
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}
