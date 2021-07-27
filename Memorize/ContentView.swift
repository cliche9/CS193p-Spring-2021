  //
//  ContentView.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    // 观测viewModel, if something changed, rebuild the ContentView
    @ObservedObject var viewModel: EmojiMemoryGame
// 设置枚举类型符合CaseIterable协议, 可以使用allCases进行枚举
//    enum Theme: CaseIterable {
//        case animals, vehicles, fruits
//
//        var title: String {
//            switch self {
//                case .animals:
//                    return "Animals"
//                case .vehicles:
//                    return "Vehicles"
//                default:
//                    return "Fruits"
//            }
//        }
//
//        var emojis: [String] {
//            switch self {
//                case .animals:
//                    return ["🐶", "🐮", "🐴", "🐱", "🐒", "🐔", "🦄", "🐤", "🐧", "🐭"]
//                case .vehicles:
//                    return ["🚗", "🚄", "🚲", "🚌", "🚑", "🚓", "🛵", "🏍️", "🚀", "🚢", "✈️"]
//                default:
//                    return ["🍎", "🍌", "🍊", "🍐", "🍋", "🍉", "🍑", "🍒", "🍍", "🥭", "🥝", "🫐", "🍓"]
//            }
//        }
//
//        var initCount: Int {
//            return Int.random(in: emojis.count / 2 ..< emojis.count)
//        }
//
//        var systemName: String {
//            switch self {
//                case .animals:
//                    return "hare"
//                case .vehicles:
//                    return "car"
//                default:
//                    return "applelogo"
//            }
//        }
//    }
//
    var body: some View {
        // Vertical Stack: 垂直布局
        // Horizontal Stack: 水平布局
        VStack {
            HStack {
                Text(EmojiMemoryGame.chosenTheme.name)
                    .font(.title)
            }
            
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
            
            HStack {
                Button(action: {
                    viewModel.themeSwitch()
                }, label: {
                    HStack {
                        Text("New Game")
                        Image(systemName: "power")
                    }
                    .font(.title)
                })
            }
//            HStack {
//                remove
//                ForEach(Theme.allCases, id: \.self, content: { theme in
//                    Button(action: {
//                        // 切换主题时发生事件
//                        chosenTheme = theme
//                        emojiCount = theme.initCount
//                        emojis = chosenTheme.emojis.shuffled()
//                    }, label: {
//                        VStack {
//                            Image(systemName: theme.systemName)
//                            Text(theme.title).font(.caption)
//                        }
//                    })
//                    .frame(maxWidth: .infinity)
//                    // 设置Button的最大宽度, 为.infinity不限制, 自动填满
//                })
//                add
//            }
//            .font(.title)
//            .padding(.horizontal)
        }
        .foregroundColor(EmojiMemoryGame.chosenTheme.color)
        .padding()
    }
    
//    var remove: some View {
//        Button(action: {
//            if emojiCount > 1 {
//                emojiCount -= 1
//            }
//        }, label: {
//            Image(systemName: "minus.circle")
//        })
//        .font(.title)
//    }
//
//    var add: some View {
//        Button(action: {
//            if emojiCount < chosenTheme.emojis.count {
//                emojiCount += 1
//            }
//        }, label: {
//            Image(systemName: "plus.circle")
//        })
//        .font(.title)
//    }
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
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
