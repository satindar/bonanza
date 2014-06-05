//
//  SetCardGame.swift
//  Bonanza
//
//  Created by SATINDAR S DHILLON on 6/4/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

import Foundation

class SetCardGame {
    
    var score: Int = 0
    var deck = SetDeck()
    var cardsInPlay = SetCard[]()
    
    init(initialCardCount: Int) {
        for index in 0..initialCardCount {
            cardsInPlay += self.deck.drawRandomcard()!
        }
    }
    
    func chooseCard(card: SetCard, atIndex index:Int) -> () {
        var pointsEarned = 0
        if (cardsInPlay[index] != nil) {
            cardsInPlay[index].isChosen = true
        }
        let cardsToCompare = chosenAndUnmatchedCards()
        if (cardsToCompare.count == 3) {
            pointsEarned = calculateScore(cardsToCompare)
        }
        if (pointsEarned < 0) {
            unchooseAllCards()
        } else if (pointsEarned > 0) {
            markChosenCardsAsMatched()
            unchooseAllCards()
        }
        self.score += pointsEarned
    }
    
    func calculateScore(cardsToCompare: SetCard[]) -> Int {
        if (deck.cardsComposeSet(cardsToCompare)) {
            return 5
        }
        return -2
    }
    
    func unchooseAllCards() -> () {
        for index in 0..self.cardsInPlay.count {
            cardsInPlay[index].isChosen = false
        }
    }
    
    func markChosenCardsAsMatched() -> () {
        for index in 0..self.cardsInPlay.count {
            if (cardsInPlay[index].isChosen) {
                cardsInPlay[index].isMatched = true
            }
        }
    }
    
    func chosenAndUnmatchedCards() -> SetCard[] {
        var cards = SetCard[]()
        for card in self.cardsInPlay {
            if (card.isChosen && !card.isMatched) {
                cards += card
            }
        }
        return cards
    }
    
}
