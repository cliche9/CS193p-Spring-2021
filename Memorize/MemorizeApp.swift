//
//  MemorizeApp.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // 在ContenView中构建ViewModel
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
