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
    
    guard let currentViewController = UIApplication.shared.keyWindow?.rootViewController else {
        return
    }
    currentViewController.present(alertController, animated: true, completion: nil)
}
