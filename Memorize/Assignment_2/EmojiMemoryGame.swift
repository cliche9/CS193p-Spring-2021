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
    
    init() {
        chosenTheme = EmojiMemoryGame.themes.randomElement()!   // Required Task 11 --- randomly chosen theme
        chosenTheme.emojis.shuffle()                            // Required Task 5 --- use all cards
        model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
    
    static var themes = [
        Theme(name: "Halloween",
              emojis: ["👻", "💀", "☠️", "🎃", "😱", "😈", "🕷", "🕸", "🦇", "👹"],
              numberOfPairsOfCards: 5,
              color: "gray"),
        Theme(name: "Animal",
              emojis: ["🐶", "🐱", "🐹", "🐰", "🐻", "🐼", "🐮", "🐵", "🐤", "🐔", "🐧", "🐴"],
              numberOfPairsOfCards: 8,
              color: "blue"),
        Theme(name: "Vehicle",
              emojis: ["🚗", "🚕", "🚌", "🚓", "🚑", "🚜", "🛵", "🚲",    "🚄", "✈️", "🚀", "🛳", "🚝"],
              numberOfPairsOfCards: 7,
              color: "red"),
        Theme(name: "Fruit",
              emojis: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍓", "🫐", "🍈", "🍒", "🍑", "🍍", "🥝", "🥑"],
              numberOfPairsOfCards: 6,
              color: "green"),
        Theme(name: "Sport",
              emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸"],
              numberOfPairsOfCards: 10,
              color: "purple"),
        Theme(name: "Food",
              emojis: ["🍞", "🍔", "🍟", "🍕", "🍗", "🍖", "🌭", "🌮", "🍤", "🍣", "🎂", "🍥"],
              numberOfPairsOfCards: 9,
              color: "orange")
    ]
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards, createCardContent: { pairIndex in theme.emojis[pairIndex] })
    }
    // pubulished that self is changed
    @Published private var model: MemoryGame<String>
    
    // current theme
    private var chosenTheme: Theme
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // get theme name
    var themeName: String {
        return chosenTheme.name
    }
    
    // return theme color
    var themeColor: Color {
        switch chosenTheme.color {
            case "gray":
                return .gray
            case "blue":
                return .blue
            case "green":
                return .green
            case "red":
                return .red
            case "purple":
                return .purple
            case "orange":
                return .orange
            default:
                return .accentColor
        }
    }
    
    // MARK: - Intent(s)
    func newTheme(name: String, emojis: [String] ,numberOfPairsOfCards: Int, color: String) {
        EmojiMemoryGame.themes.append(Theme(name: name, emojis: emojis, numberOfPairsOfCards: numberOfPairsOfCards, color: color))
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        // model.choose is mutating, if it is called, publish it
        model.choose(card)
    }
    
    func newGame() {
        // create a completely new game
        chosenTheme = EmojiMemoryGame.themes.randomElement()!   // Required Task 11 --- randomly generate
        chosenTheme.emojis.shuffle()                            // Required Task 5 --- use all cards
        model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
}
