//
//  depository.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 05.05.2022.
//

import Foundation

protocol DepositoryProtocol {
    func save (newData: [AccountProtocol])
    func load () -> [AccountProtocol]
}

class Depository : DepositoryProtocol {
    private var storage = UserDefaults.standard
    private let keyForStorage = "key"
    
    private enum keyForInside : String {
        case name
        case email
        case password

    }
    
    func save(newData: [AccountProtocol]) {
        var arrayForStorage: [[String:String]] = []
        newData.forEach{ data in
            var newElementForStorage: Dictionary <String, String> = [:]
            newElementForStorage[keyForInside.name.rawValue] = data.name
            newElementForStorage[keyForInside.email.rawValue] = data.email
            newElementForStorage[keyForInside.password.rawValue] = data.password
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: keyForStorage)
    }
    
    func load() -> [AccountProtocol] {
        var resultData: [AccountProtocol] = []
        let dataFromStorage = storage.array(forKey: keyForStorage) as? [[String:String]] ?? []
        for data in dataFromStorage {
            guard let name = data[keyForInside.name.rawValue],
                  let email = data[keyForInside.email.rawValue],
                  let password = data[keyForInside.password.rawValue]
            else {
                continue
            }
            resultData.append(User(name: name, email: email, password: password))
        }
        return resultData
    }
    
    
}
