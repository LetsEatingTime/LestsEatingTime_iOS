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
    let bottomSheetView = BottomSheetView().then {
        $0.bottomSheetColor = .white
        $0.barViewColor = .darkGray
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        present()
    }
}

extension StudentIDCardVC {
    func present() {
        [
            bottomSheetView
        ].forEach{ self.view.addSubview($0) }
        bottomSheetView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(0)
        }
    }
    
}
