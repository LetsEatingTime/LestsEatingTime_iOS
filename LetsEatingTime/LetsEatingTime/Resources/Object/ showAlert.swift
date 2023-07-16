//
//   showAlert.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/05/10.
//

import UIKit
func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    alertController.addAction(okAction)
    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}
