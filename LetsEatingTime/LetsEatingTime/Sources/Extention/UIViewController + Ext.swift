//
//  UIViewController + Ext.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/08/25.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String?,
        message: String,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
