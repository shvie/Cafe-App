//
//  LastScene.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 14.05.2022.
//

import UIKit

class LastScene: UIViewController{
    
    var storageForBooking: [BookingTable] = []


    @IBOutlet weak var numberTable: UILabel!
    @IBOutlet weak var numberGuests: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printData()

        
    }
    //выводим данные полученные данные на экран
    func printData () {
        storageForBooking.forEach { elements in
            if elements.vipRoom == true {
                numberTable.textColor = .orange
                numberTable.text = "Vip Стол \(elements.numberTable)"
                numberGuests.text = elements.numberGuests
            } else {
            numberTable.text = elements.numberTable
            numberGuests.text = elements.numberGuests
            }
        }
    }
}

