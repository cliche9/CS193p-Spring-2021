  //
//  ContentView.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    // observing viewModel, if something changed, rebuild the ContentView
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        // Vertical Stack: 垂直布局
        // Horizontal Stack: 水平布局
        VStack {
            // title
            HStack {
                Text(viewModel.themeName)
                    .font(.largeTitle)
            }
            // body content
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.themeColor)
            
            // footer: provide functions and info
            HStack {
                Button(action: {
                    viewModel.newGame()
                }, label: {
                    HStack {
                        Text("New Game")
                        Image(systemName: "power")
                    }
                })
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .font(.title)
        }
        .padding()
    }
}
  
struct CardView: View {
    // 使用card设置CardView
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 1.0)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // 将viewModel初始化PreviewProvider, 提供预览
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        // dark mode
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
