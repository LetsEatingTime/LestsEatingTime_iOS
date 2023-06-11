//
//  BottomSheetView.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/30.
//

import CoreNFC
import UIKit

//class NFCManager: NSObject, NFCNDEFReaderSessionDelegate {
//    var session: NFCNDEFReaderSession?
//
//    // NFC 태그가 감지되었을 때 호출되는 메소드
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//        // NDEF 메시지가 감지되면 UUID를 포함한 NDEF 레코드를 생성하여 태그에 쓰기
//        if let uuidString = UIDevice.current.identifierForVendor?.uuidString {
//            let payload = NFCNDEFPayload.wellKnownTypeTextPayload(string: uuidString, locale: .current)
//            let ndefMessage = NFCNDEFMessage(records: [payload])
//            session.connect(to: messages[0].records[0].wellKnownTypeURIPayload()!.absoluteString as! NFCNDEFTag) { (error: Error?) in
//                if error != nil {
//                    // 태그에 쓰기 실패
//                    print("태그에 쓰기 실패: \(error!.localizedDescription)")
//                } else {
//                    // 태그에 쓰기 성공
//                    print("태그에 UUID 쓰기 성공")
//                }
//            }
//        }
//    }
//
//    // NFC 세션 오류 발생 시 호출되는 메소드
//    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
//        // 세션 오류 처리
//        print("NFC 세션 오류: \(error.localizedDescription)")
//    }
//
//    // NFC 세션 시작
//    func startNFCSession() {
//        guard NFCNDEFReaderSession.readingAvailable else {
//            // 디바이스가 NFC를 지원하지 않을 때 처리
//            print("디바이스가 NFC를 지원하지 않습니다.")
//            return
//        }
//        
//        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
//        session?.begin()
//    }
//}
