//
//  ContentView.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

struct ChooseContentView: View {
    @State var showingGame: Bool
    @State var mode: Int
    
    var body: some View {
        if showingGame {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame(mode: mode), showingGame: $showingGame )
        }
        else {
            EmojiMemoryGameFirstView(showingGame: $showingGame, mode: $mode)
        }
    }
}

struct EmojiMemoryGameFirstView: View {
    @Binding var showingGame: Bool
    @Binding var mode: Int
    
    var body: some View {
        Group{
            Button(action: {
                withAnimation(){
                    mode = 1
                    showingGame = true
                }
            }, label: {
                ZStack{
                    Text("Modo fácil! 😅")
                }
                .menuCardify()
            })
            Button(action: {
                withAnimation(){
                    mode = 2
                    showingGame = true
                }
            }, label: {
                ZStack{
                    Text("FEITO PRA VOCÊ 😠")
                }
                .menuCardify()
            })
            Button(action: {
                withAnimation(){
                    mode = 3
                    showingGame = true
                }
            }, label: {
                ZStack{
                    Text("Modo IMPOSSÍVEL! 😰")
                }
                .menuCardify()
            })
        }
        .foregroundColor(.white)
        .padding(5)
    }
}

struct EmojiMemoryGameView: View { 
    @ObservedObject var viewModel: EmojiMemoryGame
    @Binding var showingGame: Bool
    
    var body: some View{
        VStack{
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: linearDuration)){
                        self.viewModel.choose(card: card)
                    }
            }
                .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
        }
        Button(action: {
            withAnimation(){
                showingGame = false
            }
        }, label: {
            Text("Novo jogo")
        })
    }
}

struct  CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }

    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) { animatedBonusRemaining = 0 }
    }
    
    @ViewBuilder
    private func body (for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched{
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    }else{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                .transition(.scale)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.7).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.offset(x: xOffSet, y: yOffSet))
        }
//        if card.bonusTimeRemaining == 0 && !card.isMatched {
//
//        }
    }
    //MARK: - Drawing Constants
    
    private func fontSize(for size:CGSize) -> CGFloat{
        min(size.width, size.height)*0.7
    }
}
    
    //MARK: - Numbers
private let linearDuration: Double = 0.65
private let easeInOutDuration: Double = 0.5
private let xOffSet: CGFloat = 600 //Where cards fly when desapear 
private let yOffSet: CGFloat = -(xOffSet)

    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//        EmojiMemoryGameFirstView()
        ChooseContentView(showingGame: false, mode: 2)
    }
}
