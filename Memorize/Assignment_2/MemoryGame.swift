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
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score = 0
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // pair matched
                if (cards[potentialMatchIndex].content == card.content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // previously seen card
                    if (cards[potentialMatchIndex].isPreviouslySeen) {
                        score -= 1
                    }
                    if (cards[chosenIndex].isPreviouslySeen) {
                        score -= 1
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                // not matched
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        // all face up cards have been seen
                        cards[index].isFaceUp = false
                        cards[index].isPreviouslySeen = true
                    }
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
        cards.shuffle()                         // Required Task 13 --- cards should be fully shuffled
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isPreviouslySeen: Bool = false
        var content: CardContent
        let id: Int
    }
}
