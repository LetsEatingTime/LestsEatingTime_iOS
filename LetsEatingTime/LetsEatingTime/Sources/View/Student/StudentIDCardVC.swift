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
    let contentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        present()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.contentView.snp.updateConstraints { make in
                make.height.equalTo(200)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    
}

extension StudentIDCardVC {
    func present() {
        [
            contentView
        ].forEach{ self.view.addSubview($0) }
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(560)
            $0.left.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    
}
