//
//  RegistationViewController.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 28.04.2022.
//

import UIKit

class RegistationViewController: UIViewController {
    //MARK: - Элементы на сцене
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    //MARK: - Необходимые сущности
    //Alert для удобного вызова
    let alert = Alert()
    //Передаем данные с помощью замыкания
    var doAfterEdit: ((String, String, String) -> Void)?
    
    //MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        //скрытые символы для ввода пароля
        passwordTextField.isSecureTextEntry = true
        //кнопка для просмотра скрытых символов
        passwordTextField.enablePasswordToggle()
    }
    //MARK: - Методы
    //передача данных и проверка на актуальность
    @IBAction func okButton(_ sender: Any) {
        //проверка на nil
        guard nameTextField.text != "",
              emailTextField.text != "",
              passwordTextField.text != ""
        else{
            alert.callAlert(title: "Ошибка",
                            message: "Данные не должны быть пустыми",
                            style: .actionSheet,
                            viewController: self )
        return
        }
        //проверка введенных данных
        alertForCorrectData()
        //собираем все данные и передаем через замыкание
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        doAfterEdit!(name, email, password)
        //переход к прошлой сцене
        navigationController?.popToRootViewController(animated: true)
    }
    
    //Проверка Введенных данных
    func alertForCorrectData() {
        //Условия для TextField'ов
        if nameTextField.text!.isEmpty {
            alert.callAlert(title: "Ошибка",
                            message: "Введите имя",
                            style: .actionSheet,
                            viewController: self)
            
        }else if nameTextField.text!.isValidName == false {
            alert.callAlert(title: "Ошибка",
                            message: "Введите корректное имя",
                            style: .actionSheet,
                            viewController: self)
            
        } else if emailTextField.text!.isEmpty {
            alert.callAlert(title: "Ошибка",
                            message: "Введите E-mail",
                            style: .actionSheet,
                            viewController: self)
            
        } else if emailTextField.text?.isValidEmail == false {
            alert.callAlert(title: "Ошибка",
                            message: "Введите корректный E-mail",
                            style: .actionSheet,
                            viewController: self)
            
        }else if passwordTextField.text!.isEmpty {
            alert.callAlert(title: "Ошибка",
                            message: "Введите пароль",
                            style: .actionSheet,
                            viewController: self)
            
        }else if passwordTextField.text!.count < 6 {
            alert.callAlert(title: "Ошибка",
                            message: "Пароль слишком короткий",
                            style: .actionSheet,
                            viewController: self)
        }
    }
}
