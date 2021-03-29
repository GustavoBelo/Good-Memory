//
//  MemoryGame.swift
//  Good Memory
//
//  Created by Gustavo Belo on 21/03/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{ cards.indices.filter{ cards[$0].isFaceUp }.only }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    mutating func choose(card: Card){
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardCardContentFactory:(Int) -> CardContent, difficulty: Int){
        cards = Array<Card>()
        
        switch difficulty {
            case 1: cardTime = 8.0
            case 2: cardTime = 5.0
            case 3: cardTime = 3.0
            default: cardTime = 5.0
        }

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardCardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false{
            didSet { isFaceUp ? startUsingBonusTime() : stopUsingBonusTime() }
        }
        
        var isMatched: Bool = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id: Int
    
        //MARK: - Bonus Time
        
        /*
         this could give matching bonus points
         if the user matches the card
         before a certain amount of time passes during which the card is face up
         
         can be zero which means "no bonus avaiable" for this card
         */
                
        var bonusTimeLimit: TimeInterval = TimeInterval(cardTime)
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face (and is still face up)
        var lastFaceUpDate: Date?
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        //percentage of time left before the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        //called when the card goes back down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

var cardTime = 5.0
