//
//  MemoryGame.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/25.
//

import Foundation

// 建立一个泛型struct作为MemoryGame:
// properties: cards
// functions: choose(), init()
// private(set): 令cards只读
// choose(_ card: Card): 选择一张Card, 更新Card的对应变量
// init(): 初始化MemoryGame, 主要是properties: cards
// functional programming: 使用function作为参数
// 嵌套struct: 规定了命名空间
struct MemoryGame<CardContent> where CardContent: Equatable {
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
    
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if (cards[potentialMatchIndex].content == card.content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(card)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        let id: Int
    }
}
