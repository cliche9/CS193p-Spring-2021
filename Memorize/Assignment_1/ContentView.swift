//
//  ContentView.swift
//  Memorize
//
//  Created by abc_mac on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    @State
    var emojisWithTheme = [
        "Animals": ["🐶", "🐮", "🐴", "🐱", "🐒", "🐔", "🦄", "🐤", "🐧", "🐭"],
        "Vehicles": ["🚗", "🚄", "🚲", "🚌", "🚑", "🚓", "🛵", "🏍️", "🚀", "🚢", "✈️"],
        "Fruits": ["🍎", "🍌", "🍊", "🍐", "🍋", "🍉", "🍑", "🍒", "🍍", "🥭", "🥝", "🫐", "🍓"]
    ]
    @State var chosenTheme = "Animals"
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize!")
                    .font(.largeTitle)
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100))]) {
                    ForEach(emojisWithTheme[chosenTheme]![0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                animals
                Spacer()
                vehicles
                Spacer()
                fruits
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding()
    }
    
    var animals: some View {
        Button(action: {
            if chosenTheme != "Animals" {
                chosenTheme = "Animals"
                emojisWithTheme[chosenTheme]?.shuffle()
                emojiCount = Int.random(in: 4..<emojisWithTheme[chosenTheme]!.count)
            }
        }, label: {
            VStack {
                Image(systemName: "hare")
                Text("Animals").font(.caption)
            }
            
        })
    }
    
    var vehicles: some View {
        Button(action: {
            if chosenTheme != "Vehicles" {
                chosenTheme = "Vehicles"
                emojisWithTheme[chosenTheme]?.shuffle()
                emojiCount = Int.random(in: 4..<emojisWithTheme[chosenTheme]!.count)
            }
        }, label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.caption)
            }
        })
    }
    
    var fruits: some View {
        Button(action: {
            if chosenTheme != "Fruits" {
                chosenTheme = "Fruits"
                emojisWithTheme[chosenTheme]?.shuffle()
                emojiCount = Int.random(in: 4..<emojisWithTheme[chosenTheme]!.count)
            }
        }, label: {
            VStack {
                Image(systemName: "applelogo")
                Text("Fruits").font(.caption)
            }
        })
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
            if emojiCount < emojisWithTheme[chosenTheme]!.count {
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
                shape.strokeBorder(lineWidth: 2.0)
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
    }
}
