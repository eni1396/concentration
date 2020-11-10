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
            if let matchingIndex = indexOfOnlyOneCard, matchingIndex != index {  //если подходящий индекс - индекс только одной карты и этот индекс не равен самому себе
                if cards[matchingIndex].ID == cards[index].ID {  //и если айди этих индексов совпадают
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    if !cards[matchingIndex].firstTimeSeen {
                        score -= 1
                    } else {
                        cards[matchingIndex].firstTimeSeen = true
                    }
                    cards[matchingIndex].firstTimeSeen = false
                }
                cards[index].isFacedUp = true
                indexOfOnlyOneCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOnlyOneCard = index
                if !cards[index].firstTimeSeen {
                    score -= 1
                }
                cards[index].firstTimeSeen = false
            }
        }
    }
    
    func reset() {
        cards.shuffle()
        flipCount = 0
        score = 0
        for index in cards.indices {
            cards[index].firstTimeSeen = true
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
        cards.shuffle()
    }
}


