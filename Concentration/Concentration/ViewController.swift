//
//  ViewController.swift
//  Concentration
//
//  Created by Nikita Entin on 25.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    /// экзмемляр класса, во входном параметре которого число парных карт = всему числу кнопок/2; +1 для нечетного кол-ва карт в массиве
    lazy var game = ConcentrationGame(numberOfPairedCards: (AllButtons.count + 1)/2)
    /// счетчик переворотов
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var AllButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.reset()
        flipCard()
        emojiDictionary.removeAll()
        isNewGame = true
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1
            flipCard()
        /// условие для получения номера карты, который будет получен при нажатии на кнопку по первому индексу из массива AllButtons
        if let cardNumber = AllButtons.firstIndex(of: sender) {
            game.chooseCard(index: cardNumber) // выбор карты по индексу
            flipCard() // действие при повороте карты
        }
    }
    

    func emojiMethod(card:Card) -> String {
        if emojiDictionary[card.ID] == nil {   // условие для проверки заполненности словаря
            if anotherArray.count > 0 {           //условие непустоты массива эмодзи
                let randomEmoji = Int(arc4random_uniform(UInt32(anotherArray.count)))   // рандом выбор эмодзи
                emojiDictionary[card.ID] = anotherArray.remove(at: randomEmoji)
            }
        }
        return emojiDictionary[card.ID] ?? "?"
    }
    
    
    var emojiArray = [["🎃","🕸","😈","🧟‍♀️","🧛🏻‍♂️","😵","⚰️","🦇"],["🐣","🦆","🦅","🦄","🐌","🐙","🐬"],["😀","😍","😎","🥳","🥺","😡","🤡"],["💦","☃️","🌚","🌡","⛈","🌞","🌪"],["⚾️","🏀","⚽️","🏓","🏐","🎱","🥎"]]
    var anotherArray = [String]()  // копия массива, чтобы основной не опустошался
    var emojiDictionary = [Int:String]()
    var isNewGame = true
    
    /// переворачивание карты
    func flipCard() {
        if isNewGame {
            isNewGame = false
            anotherArray = emojiArray.randomElement()!
        }
        for index in AllButtons.indices {  // прохождение индекса по всем элементам массива AllButtons
            let button = AllButtons[index]  // кнопке присваивается индекс из массива AllButtons
            let card = game.cards[index]  //карте присваивается индекс карты из класса ConcentrationGame
            if card.isMatched == true {
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
            if card.isFacedUp {  //карта повернута -да
                button.setTitle(emojiMethod(card: card), for: .normal)  // кнопке задаются рандом эмодзи
                button.backgroundColor = .green  // с зеленым фоном
            } else { //-нет
                button.setTitle("", for: .normal) //у кнопки ничего
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 0) : .systemOrange  // цвет либо красный, либо прозрачный
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        labelCounter.text = "Flips : \(game.flipCount)"
    }
}


