//
//  StudentIDCardVC.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/22.
//

import UIKit
import SnapKit
import Then


class StudentIDCardVC: UIViewController {
//    let bottomSheetView = BottomSheetView().then {
//        $0.bottomSheetColor = .white
//        $0.barViewColor = .darkGray
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        present()
//        [
//            bottomSheetView
//        ].forEach{ self.view.addSubview($0) }
//        bottomSheetView.snp.makeConstraints {
//            $0.edges.equalToSuperview().offset(0)
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMyViewController()
    }
}

extension StudentIDCardVC {
    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: BottomSheetViewController())
        present(navigationController, animated: true, completion: nil)
    }
    func present() {
        /// 밑으로 내려도 dismiss되지 않는 옵션 값
        isModalInPresentation = true
        
        if let sheet = sheetPresentationController {
            let myCustomHeight = UISheetPresentationController.Detent.init(width: .fractionalWidth(1.0), height: .absolute(400))
            
            /// 드래그를 멈추면 그 위치에 멈추는 지점: default는 large()
            sheet.detents = [.myCustomHeight(), .medium(), .large()]
            /// 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            /// sheet아래에 위치하는 ViewController를 흐려지지 않게 하는 경계값 (medium 이상부터 흐려지도록 설정)
            sheet.largestUndimmedDetentIdentifier = .medium
            /// sheet로 present된 viewController내부를 scroll하면 sheet가 움직이지 않고 내부 컨텐츠를 스크롤되도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            /// grabber바 보이도록 설정
            sheet.prefersGrabberVisible = true
        }
    }
}
extension StudentIDCardVC: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {

    }
}
