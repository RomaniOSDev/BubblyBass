//
//  CardSearchGameViewModel.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//
//

import Foundation
import SwiftUI
import Combine

final class CardSearchGameViewModel: ObservableObject {
    struct Card: Identifiable, Equatable {
        let id: UUID
        let pairId: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var isDisabled: Bool
    }
    
    enum GameState {
        case notStarted
        case inProgress
        case won
        case lost
    }
    
    @Published private(set) var cards: [Card] = []
    @Published private(set) var level: Int = 1
    @Published private(set) var timeRemaining: Int = 0
    @Published private(set) var movesCount: Int = 0
    @Published private(set) var state: GameState = .notStarted
    @Published private(set) var firstFlippedCardIndex: Int? = nil
    @Published var showLevelsSheet: Bool = false
    
    private var timer: Timer?
    private let gridCardCount: Int = 12 // 3x4
    
    // Configure per-level time limits (seconds). 12 levels.
    // Easier levels have more time; later levels less.
    private let timePerLevel: [Int] = [
        90, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30
    ]
    
    init(level: Int = 1) {
        let clamped = max(1, min(12, level))
        self.level = clamped
    }
    
    func selectLevel(_ newLevel: Int) {
        let clamped = max(1, min(12, newLevel))
        level = clamped
        startNewGame()
    }
    
    func startNewGame() {
        stopTimer()
        movesCount = 0
        state = .inProgress
        firstFlippedCardIndex = nil
        generateDeck()
        timeRemaining = timePerLevel[level - 1]
        startTimer()
    }
    
    func flipCard(at index: Int) {
        guard state == .inProgress else { return }
        guard cards.indices.contains(index) else { return }
        guard !cards[index].isFaceUp, !cards[index].isMatched, !cards[index].isDisabled else { return }
        
        cards[index].isFaceUp = true
        if let firstIndex = firstFlippedCardIndex {
            // Second flip
            movesCount += 1
            cards.indices.forEach { i in
                if !cards[i].isFaceUp && !cards[i].isMatched {
                    cards[i].isDisabled = true
                }
            }
            let isMatch = cards[firstIndex].pairId == cards[index].pairId
            if isMatch {
                cards[firstIndex].isMatched = true
                cards[index].isMatched = true
                cards.indices.forEach { i in cards[i].isDisabled = false }
                firstFlippedCardIndex = nil
                checkWinCondition()
            } else {
                // Flip back after short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
                    guard let self else { return }
                    if self.cards.indices.contains(firstIndex) { self.cards[firstIndex].isFaceUp = false }
                    if self.cards.indices.contains(index) { self.cards[index].isFaceUp = false }
                    self.cards.indices.forEach { i in self.cards[i].isDisabled = false }
                    self.firstFlippedCardIndex = nil
                }
            }
        } else {
            // First flip
            firstFlippedCardIndex = index
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.state == .inProgress else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.state = .lost
                self.stopTimer()
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func checkWinCondition() {
        let allMatched = cards.allSatisfy { $0.isMatched }
        if allMatched {
            state = .won
            stopTimer()
            addWinCoins()
            unlockNextLevelIfNeeded()
        }
    }
    
    private func generateDeck() {
        // Всегда 12 карт (6 пар). Используем ровно card1..card6.
        let pairIds = Array(1...6)
        var deck: [Card] = []
        for pair in pairIds {
            deck.append(Card(id: UUID(), pairId: pair, isFaceUp: false, isMatched: false, isDisabled: false))
            deck.append(Card(id: UUID(), pairId: pair, isFaceUp: false, isMatched: false, isDisabled: false))
        }
        deck.shuffle()
        cards = deck
    }

    private func unlockNextLevelIfNeeded() {
        let next = min(12, level + 1)
        let key = "maxUnlockedLevel"
        let current = UserDefaults.standard.integer(forKey: key)
        let currentEffective = max(current, 1)
        if next > currentEffective {
            UserDefaults.standard.set(next, forKey: key)
        }
    }

    private func addWinCoins() {
        let key = "coins"
        let current = UserDefaults.standard.integer(forKey: key)
        UserDefaults.standard.set(current + 1500, forKey: key)
    }
}

//
//  CardSearchGameViewModel.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

