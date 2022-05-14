//
//  FirstViewController.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 04.05.2022.
//
import UIKit

class FirstViewController: UIViewController {
    //MARK: - Необходимые сущности
    let story = UIStoryboard(name: "Main", bundle: nil)
    //Ссылка на alert для удобного вызова
    let alert = Alert()
    //Ссылка на хранилище
    var storage: DepositoryProtocol = Depository()
    //Временное хранилище для проверки введеных данных
    private var array: [AccountProtocol] = [] {
        didSet {
            //Как только новые данные попадают загружаем в UserDefaults
            storage.save(newData: array)
        }
    }
    //MARK: - Элементы на сцене
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    //MARK: -  Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        //Загружаем данные из UserDefaults
        loadData()
        //скрытые символы для пароля
        passwordTextField.isSecureTextEntry = true
        //кнопка чтобы показать скрытые сиволы
        passwordTextField.enablePasswordToggle()
        print(array)
        //
        emailTextField.addOnlyBottomBorder()
        passwordTextField.addOnlyBottomBorder()
    }


    //MARK: - Методы
    
    //загрузка данных в массив
    private func loadData() {
         array = storage.load()
    }
    
    //получаем данные с помощью замыкания и передаем их в массив
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditAccount" {
        let destination = segue.destination as! RegistationViewController
            destination.doAfterEdit = { [unowned self] name, email, password in
                let newAccount = User(name: name, email: email, password: password)
                array.append(newAccount)
            }
        }
    }
    
    //Кнопка войти
    @IBAction func enterButton(_ sender: Any) {
        guard emailTextField.text != "",
              passwordTextField.text != ""
        else {
            alert.callAlert(title: "Ошибка",
                            message: "Данные не должны быть пустыми",
                            style: .actionSheet,
                            viewController: self)
            return
        }
        //проверка на корректность ввода Email
        if emailTextField.text?.isValidEmail == false {
            alert.callAlert(title: "Ошибка",
                            message: "Email введен некорректно",
                            style: .actionSheet,
                            viewController: self)
        }
        //результат проверки на наличие введенных данных 
        let resultValidate = validData()
        //Если данные присутствуют то открываем экран заказа стола
        if resultValidate == true {
            let nextScene = story.instantiateViewController(withIdentifier: "customiseTable")
            navigationController?.pushViewController(nextScene, animated: true)
            emailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            // если нет данных, ошибка
        } else {
            alert.callAlert(title: "Ошибка", message: "Данные введены неправильно", style: .actionSheet, viewController: self)
        }
    }
    private func validData() -> Bool {
        //Проверяем есть ли в массиве данные которые ввел пользователь
        let conteinsData = array.contains { AccountProtocol in
            let s1 = AccountProtocol.password == passwordTextField.text!
             let s2 = AccountProtocol.email == emailTextField.text!
             if s1 == true, s2 == true {
                 return true
             } else {
                 return false
             }
         }
        return conteinsData
    }
}


