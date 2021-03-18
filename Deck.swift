//
//  Deck.swift
//  cardGame
//
//  Created by Jason Fujii on 3/17/21.
//

import Foundation

enum Suit: String, CustomStringConvertible, CaseIterable {
    case Diamond = "♦️"
    case Club = "♣️"
    case Heart = "❤️"
    case Spade = "♠️"
    
    var description: String {
        return rawValue
    }
}

//Numeric cards: 2 - 10
enum NumericRank: Int {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
}

//Face cards: Jack, Queen, King, Ace
enum FaceRank: Int {
    case Jack = 11
    case Queen
    case King
    case Ace = 1
}

enum CardRank {
    case numeric(NumericRank)
    case face(FaceRank)
    
    var value: Int {
        switch self {
        case .numeric(let numericRank):
            return numericRank.rawValue
        case .face(let faceRank):
            return faceRank.rawValue
        }
    }
    
    //?: "Failable initializer" - could return nil
    init?(rawValue: Int) {
        //In Enums, we can set ourselves as something else. Can't do this in classes
        if let faceRank = FaceRank(rawValue: rawValue) {
            self = .face(faceRank)
        } else if let numericRank = NumericRank(rawValue: rawValue) {
            self = .numeric(numericRank)
        } else {
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .numeric(let numeric):
            return "\(numeric.rawValue)"
        case .face(let face):
            return "\(face)"
        }
    }
}

struct PlayingCard: CustomStringConvertible {
    let suit: Suit
    let rank: CardRank
    
    var description: String {
        return "\(rank.value) of \(suit)"
    }
}

var ourCard = PlayingCard(suit: .Heart, rank: .face(.Ace))



class Deck {
    private var cards: [PlayingCard]
    private var currentIndex = 0
    
    //computed property
    //Not changing a property, so we can make it a computed property
    var currentCard: PlayingCard? {
        //if-else statement put into one line
        return currentIndex < cards.count ? cards[currentIndex] : nil
    }
    
    init() {
        cards = []
        /*
         For a deck of cards:
         - Iterate through the suits
         - For each suit, iterate through values 1 - 13
        */
        
        for suit in Suit.allCases {
            for rankNumeric in 1...13 {
                if let rank = CardRank(rawValue: rankNumeric) {
                    let playingCard = PlayingCard(suit: suit, rank: rank)
                    cards.append(playingCard)
                }
            }
        }
    }
    
    func drawCard() -> PlayingCard? {
        if let currentCard = currentCard {
            return currentCard
        } else {
            return nil
        }
    }
    
    
    func shuffle() {
        currentIndex = 0
        cards.shuffle()
    }
}
