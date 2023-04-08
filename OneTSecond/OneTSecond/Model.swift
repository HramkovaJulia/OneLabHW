//
//  Model.swift
//  OneTSecond
//
//  Created by Artyom Prima on 02.04.2023.
//

import Foundation

struct InfoContact: Equatable {

    var name: String
    var phone: String
    
    static func == (lhs: InfoContact, rhs: InfoContact) -> Bool {
         return lhs.name == rhs.name && lhs.phone == rhs.phone
     }
}

var contactMembers: [InfoContact] = [
InfoContact(name: "Юлия", phone: "868675775"),
InfoContact(name: "Artem", phone: "85574636"),
InfoContact(name: "Abay", phone: "59595959"),
InfoContact(name: "Asiya", phone: "58588585"),
InfoContact(name: "Alina", phone: "4949499494"),
InfoContact(name: "Мама", phone: "868675775"),
InfoContact(name: "Тамерлан", phone: "85574636"),
InfoContact(name: "Зере", phone: "59595959"),
InfoContact(name: "Бейбарыс", phone: "58588585"),
InfoContact(name: "Дана", phone: "4949499494"),
InfoContact(name: "Куаныш", phone: "868675775"),
InfoContact(name: "Динара", phone: "85574636"),
InfoContact(name: "Ильяс", phone: "59595959"),
InfoContact(name: "Жанара", phone: "58588585"),
InfoContact(name: "Ержан", phone: "4949499494"),
]


