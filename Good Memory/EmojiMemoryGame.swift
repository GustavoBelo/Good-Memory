//
//  EmojiMemoryGame.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

class EmojiMemoryGame: ObservedObject {
    @Published private var model: EmojiMemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    private static func createMemoryGame() -> MemoryGame<String>{
        let emojis = ["👻", "😅", "🥵", "😇"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count){ pairIndex in
            return emojis[pairIndex]
        }
    }

    //MARK: - Access to the Model
    var cards: Array <MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intet(s)
    
    func choose(card: MemoryGame<String>){
        model.choose(card: card)
    }
}
