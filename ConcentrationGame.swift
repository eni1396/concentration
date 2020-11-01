//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Nikita Entin on 27.10.2020.


import Foundation

class ConcentrationGame {
    
    /// массив кард от структуры Card
    var cards = [Card]()
    
    var indexOfOnlyOneCard: Int?
    
    /// выбор одной карты
    /// - Parameter index: индекс карты в массиве [Card]
    func chooseCard(index: Int) {
        if !cards[index].isMatched { //если карта по индексу не соответсвует
            if let mathcingIndex = indexOfOnlyOneCard, mathcingIndex != index {  //если подходящий индекс - индекс только одной карты и этот индекс не равен самому себе
                if cards[mathcingIndex].ID == cards[index].ID { //и если айди этих индексов совпадают
                cards[mathcingIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFacedUp = true //здесь ??
            indexOfOnlyOneCard = nil
        } else {
            for flipDown in cards.indices {
                cards[flipDown].isFacedUp = false
            }
            cards[index].isFacedUp = true
            indexOfOnlyOneCard = index
        }
        }
    }
    
    /// инициализатор для числа парных карт
    /// - Parameter numberOfPairedCards: число парных карт
    init(numberOfPairedCards:Int) {
//      цикл от нуля до числа парных карт
        for _ in 0..<numberOfPairedCards {
            /// создание экземпляра карты из структуры Card
        let card = Card()
//          добавление в массив двух карт-экземпляров
            cards += [card,card]
        }
        
        var anyCardIndex = cards.count - 1 //тут вопрос
        
        if anyCardIndex != 0 {
            var randomIndex = Int(arc4random_uniform(UInt32(anyCardIndex)))
            swap(&anyCardIndex, &randomIndex)
        }
        anyCardIndex -= 1 // и тут вопрос. И по итогу они перемешиваются только при cmd + R
        
}
}
