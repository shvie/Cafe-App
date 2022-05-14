//
//  File.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 28.04.2022.
//

import Foundation
import UIKit

//MARK: - Кнопка скрытия введеных символов
extension UITextField {
    
    func enablePasswordToggle(){
        //Создаем кнопку
        let button = UIButton(type: .custom)
        //Задаем картинку
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eyefill"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        button.alpha = 0.4
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
//MARK: - Расширение для String на проверку email
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
//MARK: - Расширение для String на проверку name
extension String {
    var isValidName: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Zа-яА-Я\\_]{2,10}$").evaluate(with: self)
    }

}
//MARK: - TextField
extension UITextField {
    
    func addOnlyBottomBorder() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
    
}
//MARK: - alert
class Alert {
    func callAlert (title: String, message: String, style: UIAlertController.Style, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true)
    }
}

