//
//  Card.swift
//  Concentration
//
//  Created by Nikita Entin on 27.10.2020.
//

import Foundation

struct Card: Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    /// Статус перевернутости
    var isFacedUp = false
    ///  Соответствие двух выбранных карт
    var isMatched = false
    var ID: Int = 0
    var firstTimeSeen = true
    
    /// свойство айди для функции генерирования айди
    private static var id = 0
    
    /// генерация уникального айди
    /// - Returns: айди функции +1
    private static func idGenerator() -> Int {
        id += 1
        return id
    }
    
    /// инициализатор, где айди присваивается метод генерирования уникального айди
    init() {
        self.ID = Card.idGenerator()
    }
}

