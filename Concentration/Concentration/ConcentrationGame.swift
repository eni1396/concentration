//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Nikita Entin on 27.10.2020.


import Foundation

class ConcentrationGame {
    
    /// массив карт от структуры Card
    var cards = [Card]()
    
    var indexOfOnlyOneCard: Int?
    var flipCount = 0
    var score = 0 /*
    Add a game score label to your UI. Score the game by giving 2 points for every match
    and penalizing 1 point for every previously seen card that is involved in a mismatch.
     */
    
    /// выбор одной карты
    /// - Parameter index: индекс карты в массиве [Card]
    func chooseCard(index: Int) {
        if !cards[index].isMatched { //если карта по индексу не соответсвует
            if let mathcingIndex = indexOfOnlyOneCard, mathcingIndex != index {  //если подходящий индекс - индекс только одной карты и этот индекс не равен самому себе
                if cards[mathcingIndex].ID == cards[index].ID {  //и если айди этих индексов совпадают
                    cards[mathcingIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFacedUp = true
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
    
    func reset() {
        for index in cards.indices { //проходимся по индексам массива и переворачиваем карты и убираем соответствия
            cards[index].isFacedUp = false
            cards[index].isMatched = false
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
        //        var randomCard = cards
        //        randomCard.shuffle()
        cards.shuffle()
    }
}


