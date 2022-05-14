//
//  Model account.swift
//  registrationApp
//
//  Created by Vitaliy Shmelev on 05.05.2022.
//

import Foundation
//MARK: - Протокол для аккаунта
protocol AccountProtocol {
    var name: String { get set }
    var email: String { get set }
    var password: String { get set }
}
//MARK: - Протокол для заказа стола
protocol BookingTableProtocol {
    var numberGuests: String { get set }
    var vipRoom : Bool { get set }
    var serviceAnimator: Bool { get set }
    var numberTable: String { get set }
}
//MARK: - Сущность заказ стола с данными о заказе
struct BookingTable: BookingTableProtocol {
    var numberGuests: String
    var vipRoom: Bool
    var serviceAnimator: Bool
    var numberTable: String
}
//MARK: - Сущность юзер с даннымы об аккаунте
struct User: AccountProtocol {
    var name: String
    var email: String
    var password: String
}
