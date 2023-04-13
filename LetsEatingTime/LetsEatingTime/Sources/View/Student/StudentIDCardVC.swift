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

class StudentIDCardVC: UIViewController {
    
    
    let studentShowMealsVC = StudentShowMealsVC()
    var studentShowMealsView: UIView {
        self.studentShowMealsVC.view
    }
    
    let scrollView = UIScrollView()
    
    var contentView = UIView()

    let studentIDCard = UIImageView().then {
        $0.image = UIImage(named: "studentIDCard")
    }
    
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
        let VC = StudentShowMealsVC()
        present(VC, animated: true, completion: nil)
    }
    
    @objc func didPressLogoutButton() {
        let VC = StudentShowMealsVC()
        present(VC, animated: true, completion: nil)
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
        contentView.addSubview(mealsView)
        contentView.addSubview(mealsButton)
        contentView.addSubview(infomationChangeButton)
        contentView.addSubview(logoutButton)
        contentView.addSubview(withdrawalButton)
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
        ].forEach{ self.view.addSubview($0) }
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
            let uuid = UUID()
            let payload = NFCNDEFPayload(format: .nfcWellKnown, type: "uuid".data(using: .utf8)!, identifier: Data(), payload: uuid.uuidString.data(using: .utf8)!)
            let ndefMessage = NFCNDEFMessage(records: [payload])
            
            completionHandler(ndefMessage, nil)
            print("UUIDSuccess")
        }
        
        func writeNDEF(_ ndefMessage: NFCNDEFMessage, completionHandler: @escaping (Error?) -> Void) {  //NDEF 메시지를 쓰는 고유 로직
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
    
//    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
//        print("NFC session did invalidate with error: \(error.localizedDescription)")
//    }
////    let nfctag = NFCNDEFTag.self
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//        if let tag = session.connect(to: .`self`(NFCNDEFTag), completionHandler: { (error: Error?) in
//                if let error = error {
//                    print("Failed to connect to NFC tag: \(error.localizedDescription)")
//                } else {
//                    print("Success😁")
//                }
//            }), tag.isWritable {
//            let uuid = UUID()
//            let uuidData = uuid.uuidString.data(using: .utf8)!
//            let payload = NFCNDEFPayload(format: .nfcWellKnown, type: Data("T".utf8), identifier: Data(), payload: uuidData)
//            let message = NFCNDEFMessage(records: [payload])
//            tag.writeNDEF(message) { error in
//                if let error = error {
//                    print("Failed to write UUID to NFC tag: \(error.localizedDescription)")
//                } else {
//                    print("Successfully wrote UUID to the NFC tag")
//                }
//            }
//            } else {
//                print("NFC tag is not writable or not available")
//            }
//            session.invalidate()
//    }
}
