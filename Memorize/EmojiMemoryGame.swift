//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/25.
//

import SwiftUI

// 构造ViewModel作为Model和View的中介
// EmojiMemoryGame实现MemoryGame的一种实例
// model: ViewModel中的model, 此处为MemoryGame<String>
// cards: model.cards的一个copy, private的model为外部访问cards提供接口
class EmojiMemoryGame: ObservableObject {
    // EmojiMemoryGame is obervable
    enum Theme {
        case Halloween
        case Animal
        case Vehicle
        case Fruit
        case Sport
        case Food
        
        var emojis: [String] {
            switch self {
                case .Halloween:
                    return ["👻", "💀", "☠️", "🎃", "😱", "😈", "🕷", "🕸", "🦇", "👹"]
                case .Animal:
                    return ["🐶", "🐱", "🐹", "🐰", "🐻", "🐼", "🐮", "🐵", "🐤", "🐔", "🐧", "🐴"]
                case .Vehicle:
                    return ["🚗", "🚕", "🚌", "🚓", "🚑", "🚜", "🛵", "🚲", "🚄", "✈️", "🚀", "🛳", "🚝"]
                case .Fruit:
                    return ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍓", "🫐", "🍈", "🍒", "🍑", "🍍", "🥝", "🥑"]
                case .Sport:
                    return ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸"]
                case .Food:
                    return ["🍞", "🍔", "🍟", "🍕", "🍗", "🍖", "🌭", "🌮", "🍤", "🍣", "🎂", "🍥"]
            }
        }
        
        var color: Color {
            switch self {
                case .Halloween:
                    return .gray
                case .Animal:
                    return .blue
                case .Vehicle:
                    return .red
                case .Fruit:
                    return .green
                case .Sport:
                    return .purple
                case .Food:
                    return .orange
            }
        }
        
        var name: String {
            switch self {
                case .Halloween:
                    return "Halloween"
                case .Animal:
                    return "Animal"
                case .Vehicle:
                    return "Vehicle"
                case .Fruit:
                    return "Fruit"
                case .Sport:
                    return "Sport"
                case .Food:
                    return "Food"
            }
        }
    }
    
    static var chosenTheme = Theme.Animal
    
    static func createMemoryGame() -> MemoryGame<String> {
        let count = chosenTheme.emojis.count
        let emojis = chosenTheme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: count/2 ... count), createCardContent: { pairIndex in emojis[pairIndex] })
    }
    // pubulished that self is changed
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        // model.choose is mutating, if it is called, publish it
        model.choose(card)
    }
    
    func themeSwitch() {
        EmojiMemoryGame.chosenTheme = 
    }
}
