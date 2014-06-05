//
//  SetCard.swift
//  Bonanza
//
//  Created by SATINDAR S DHILLON on 6/3/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

import Foundation

struct SetCard {
    let symbol: Int, pattern: Int, color: Int, symbolCount: Int
    var isChosen: Bool, isMatched: Bool
    init(symbol: Int, pattern: Int, color: Int, symbolCount: Int) {
        self.symbol = symbol
        self.pattern = pattern
        self.color = color
        self.symbolCount = symbolCount
        self.isChosen = false
        self.isMatched = false
    }
}

class SetDeck {
    
    var cardsInDeck = SetCard[]()
    
    init() {
        for symbol in 1...3 {
            for pattern in 1...3 {
                for color in 1...3 {
                    for symbolCount in 1...3 {
                        cardsInDeck += SetCard(
                                         symbol: symbol,
                                         pattern: pattern,
                                         color: color,
                                         symbolCount: symbolCount)
                    }
                }
            }
        }
    }
    
  
    func drawRandomcard() -> SetCard? {
        if cardsInDeck.count < 1 {
            return nil
        }
        let cardIndex = Int(arc4random()) % cardsInDeck.count
        let randomCard = cardsInDeck[cardIndex]
        cardsInDeck.removeAtIndex(cardIndex)
        return randomCard
    }
    
    
    func cardsComposeSet(cardsToCompare: SetCard[]) -> Bool {

        func attributesComposeSet(attributeValues: Int[]) -> Bool {
            let attributeSet = NSSet(array: attributeValues)
            return (attributeSet.count == cardsToCompare.count || attributeSet.count == 1)
        }
        
        let symbols = cardsToCompare.map({
            (card: SetCard) -> Int in
            return card.symbol
            })
        if !attributesComposeSet(symbols) {
            return false
        }
        
        let patterns = cardsToCompare.map({
            (card: SetCard) -> Int in
            return card.pattern
            })
        if !attributesComposeSet(patterns) {
            return false
        }
        
        let colors = cardsToCompare.map({
            (card: SetCard) -> Int in
            return card.color
            })
        if !attributesComposeSet(colors) {
            return false
        }
        
        let symbolCounts = cardsToCompare.map({
            (card: SetCard) -> Int in
            return card.symbolCount
            })
        if !attributesComposeSet(symbolCounts) {
            return false
        }
        return true
    }
    
}



