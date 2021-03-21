//
//  ContentView.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View{
        Grid (viewModel.cards){ cards in
            CardView(card: card).onTapGesture{
                self.viewModel.choose(card: card)
        }
            .padding(5)
    }
        .padding()
        .foregroundColor(Color.orange)
}

    struct  CardView: View {
        var card: MemoryGame<String>.Card
        var body: some View{
            GeometryReader{
                
            }
        }
    
    }
    
    
    
    
    
    
    
    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
