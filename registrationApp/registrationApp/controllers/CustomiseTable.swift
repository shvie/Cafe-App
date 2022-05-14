//
//  CustomiseTable.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 04.05.2022.
//

import UIKit

class CustomiseTable: UIViewController {
    //MARK: - Необходимые элементы для работы
    let call = Alert()
    //Ссылка на storyboard
    let scene = UIStoryboard(name: "Main", bundle: nil)
    //Замыкание для передачи данных
    var doAfterEdit: ((Bool) -> Void)?
    //MARK: - Элементы на сцене
    @IBOutlet weak var numberOfGuests: UITextField!
    @IBOutlet weak var vipRoomSw: UISwitch!
    @IBOutlet weak var serviceAnimatorsSw: UISwitch!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var numberTable: UITextField!
    
    //MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceAnimatorsSw.isOn = false
        //загружаем image для главного меню 
        setImage()
        //Убираем кнопку "назад" из navigation
        self.navigationItem.setHidesBackButton(true, animated: true)
        //Установка кнопки выйти
        settingsForItemBar()
        //Отключаем крупный текст в navigationBar
        self.navigationItem.largeTitleDisplayMode = .never
    }
    //MARK: - Методы
    //Т.к создать кнопку в сториборде нет возможности (сцена не связа с прошлой сценой по segue содаем кнопку программно
    func settingsForItemBar() {
        let item = UIBarButtonItem(title: "Выйти", style: .done, target: self, action: #selector(backToRootScene))
        self.navigationItem.rightBarButtonItem = item
    }
    //Действие для кнопки выхода
    @objc func backToRootScene() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //Ставим изображение для headerImage
    func setImage() {
        headerImage.image = UIImage(named: "logo")
    }
    
    //проверка на кол-во гостей
    func invalidNumberOFGuests (_ value: String) -> Bool {
        let set = CharacterSet(charactersIn: value)
        //Проверка введенных данных
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            call.callAlert(title: "Ошибка",
                           message: "Данные должны состоять из цифр",
                           style: .actionSheet,
                           viewController: self)
        } else if value.count > 3 {
            call.callAlert(title: "Ошибка",
                           message: "Данные не должны превышать 3-ёх шт",
                           style: .actionSheet,
                           viewController: self)
        }
        return true
    }
    
    @IBAction func bookingButton(_ sender: Any) {
        let alert = UIAlertController(title: "Забронировать?",
                                      message: "",
                                      preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Нет", style: .destructive)
        let action = UIAlertAction(title: "Да", style: .cancel, handler: { [self] action in
            
            //ссылка на следующую сцену
            let next = scene.instantiateViewController(withIdentifier: "finishScene") as! LastScene
            
            //Проверка введенных данных 
            guard self.numberOfGuests.text! != "",
                  self.invalidNumberOFGuests(numberOfGuests.text!) != false,
                  self.invalidNumberOFGuests(numberTable.text!) != false
            else {
                self.numberOfGuests.text!.removeAll()
                self.call.callAlert(title: "Ошбика",
                               message: "Данные введены неверно",
                               style: .actionSheet,
                               viewController: self)
                return
            }
            next.storageForBooking.append(BookingTable(numberGuests: numberOfGuests.text!, vipRoom: vipRoomSw.isOn, serviceAnimator: serviceAnimatorsSw.isOn, numberTable: numberTable.text!))
            self.navigationController?.pushViewController(next, animated: true)
            
        })
        alert.addAction(action2)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}
