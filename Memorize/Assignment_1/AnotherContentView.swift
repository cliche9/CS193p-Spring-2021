//
//  ContentView.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    
    // 设置枚举类型符合CaseIterable协议, 可以使用allCases进行枚举
    enum Theme: CaseIterable {
        case animals, vehicles, fruits
        
        var title: String {
            switch self {
                case .animals:
                    return "Animals"
                case .vehicles:
                    return "Vehicles"
                default:
                    return "Fruits"
            }
        }
        
        var emojis: [String] {
            switch self {
                case .animals:
                    return ["🐶", "🐮", "🐴", "🐱", "🐒", "🐔", "🦄", "🐤", "🐧", "🐭"]
                case .vehicles:
                    return ["🚗", "🚄", "🚲", "🚌", "🚑", "🚓", "🛵", "🏍️", "🚀", "🚢", "✈️"]
                default:
                    return ["🍎", "🍌", "🍊", "🍐", "🍋", "🍉", "🍑", "🍒", "🍍", "🥭", "🥝", "🫐", "🍓"]
            }
        }
        
        var initCount: Int {
            return Int.random(in: emojis.count / 2 ..< emojis.count)
        }
        
        var systemName: String {
            switch self {
                case .animals:
                    return "hare"
                case .vehicles:
                    return "car"
                default:
                    return "applelogo"
            }
        }
    }
    
    // 可变, 用来指定当前主题
    @State var chosenTheme = Theme.animals
    // 使用emojis确定当前theme, 避免++--时shuffle()
    @State var emojis = Theme.animals.emojis
    @State var emojiCount = Theme.animals.initCount
    
    var body: some View {
        // Vertical Stack: 垂直布局
        // Horizontal Stack: 水平布局
        VStack {
            HStack {
                Text("Memorize!")
                    .font(.title)
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.red)
            
            HStack {
                remove
                ForEach(Theme.allCases, id: \.self, content: { theme in
                    Button(action: {
                        // 切换主题时发生事件
                        chosenTheme = theme
                        emojiCount = theme.initCount
                        emojis = chosenTheme.emojis.shuffled()
                    }, label: {
                        VStack {
                            Image(systemName: theme.systemName)
                            Text(theme.title).font(.caption)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    // 设置Button的最大宽度, 为.infinity不限制, 自动填满
                })
                add
            }
            .font(.title)
            .padding(.horizontal)
        }
        .padding()
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
        .font(.title)
    }

    var add: some View {
        Button(action: {
            if emojiCount < chosenTheme.emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
        .font(.title)
    }
}
  
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 1.0)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
