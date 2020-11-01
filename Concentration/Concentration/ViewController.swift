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
    var flipCount = 0{
        didSet{
            labelCounter.text = "Flips : \(flipCount)"
        }
    }
    @IBOutlet weak var labelCounter: UILabel!
  
    @IBOutlet var AllButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if flipCount > 15 {      //по достижению 15 кликов игра начинается заново
            reset()
        }
        
        /// условие для получения номера карты, который будет получен при нажатии на кнопку по первому индексу из массива AllButtons
        if let cardNumber = AllButtons.firstIndex(of: sender) {
            game.chooseCard(index: cardNumber) // выбор карты по индексу
            flipCard() // действие при повороте карты
        }
        else {
            print("Fail")
        }
    }
    
    func reset() {
        flipCount = 0
        game.reset()
    }

    var emojiArray = ["🐞", "🐸", "🐔", "⚽️", "🎾", "🎲", "🚀", "💸", "🔮", "🧸"]
    var emojiDictionary = [Int:String]()
    
    /// метод по переносу эмодзи из массива с эмодзи в словарь для вызова по номеру
    /// - Parameter card: просто карта
    /// - Returns: добавляет эмодзи в словарь, убирая его из массива
    func emojiMethod(card:Card) -> String {
        if emojiDictionary[card.ID] == nil {   // условие для проверки заполненности словаря
            if emojiArray.count > 0 {           //условие непустоты массива эмодзи
                let randomEmoji = Int(arc4random_uniform(UInt32(emojiArray.count)))   // рандом выбор эмодзи
                emojiDictionary[card.ID] = emojiArray.remove(at: randomEmoji)
            }
        }
        return emojiDictionary[card.ID] ?? "?"
    }
    
    
    /// переворачивание карты
    func flipCard() {
        for index in AllButtons.indices {  // прохождение индекса по всем элементам массива AllButtons
            let button = AllButtons[index]  // кнопке присваивается индекс из массива AllButtons
            let card = game.cards[index]  //карте присваивается индекс карты из класса ConcentrationGame
            if card.isFacedUp {  //карта повернута -да
                button.setTitle(emojiMethod(card: card), for: .normal)  // кнопке задаются рандом эмодзи
                button.backgroundColor = .green  // с зеленым фоном
            } else { //-нет
                button.setTitle("", for: .normal) //у кнопки ничего
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)  // цвет либо красный, либо прозрачный
            }
        }
    }

}


