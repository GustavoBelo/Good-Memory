//
//  EmojiMemoryGame.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame = EmojiMemoryGame.createMemoryGame(mode: 3)

    private static func createMemoryGame(mode: Int) -> MemoryGame<String>{
        let emojis = ["👁", "😅", "🥵", "😇", "🤪", "🐝", "😡", "🤡", "🤫"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count, cardCardContentFactory:{ pairIndex in
            return emojis[pairIndex]
        }, difficulty: mode)
    }
    
    //MARK: - Access to the Model
    var cards: Array <MemoryGame<String>.Card>{
        model.cards
    }
    //MARK: - Intet(s)
    
    init(mode: Int) {
        model = EmojiMemoryGame.createMemoryGame(mode: mode)
    }
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
//    func reset(mode: Int){
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame(mode: mode))
//    }
}
