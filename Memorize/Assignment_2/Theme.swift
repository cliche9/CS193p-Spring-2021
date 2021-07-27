//
//  Theme.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/27.
//

import Foundation


struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairsOfCards: Int
    var color: String
    
    init(name: String, emojis: [String], numberOfPairsOfCards: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards =         // Required Task 7 --- no more pairs than the count of available emoji
            numberOfPairsOfCards > emojis.count ? emojis.count : numberOfPairsOfCards
        self.color = color
    }
}
