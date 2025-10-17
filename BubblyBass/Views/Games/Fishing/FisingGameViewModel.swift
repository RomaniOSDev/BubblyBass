//
//  FisingGameViewModel.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

import Foundation
import SwiftUI
import Combine

final class FisingGameViewModel: ObservableObject {
    struct SwimmingFish: Identifiable {
        let id: UUID = UUID()
        let type: Fish
        var x: CGFloat
        var y: CGFloat
        var speed: CGFloat
    }

    @Published private(set) var fishes: [SwimmingFish] = []
    @Published private(set) var caughtCount: Int = 0
    @Published private(set) var goalCount: Int = 10
    @Published var isCasting: Bool = false
    @Published var statusText: String = ""
    @Published var showStatus: Bool = false
    @Published private(set) var caughtFish: [Fish] = []
    @Published var isFinished: Bool = false
    
    private var movementTimer: Timer?
    private var spawnTimer: Timer?
    
    // Screen size cache to keep Y within bottom half
    private var lastWidth: CGFloat = 0
    private var lastHeight: CGFloat = 0
    
    func start(width: CGFloat, height: CGFloat) {
        lastWidth = width
        lastHeight = height
        stop()
        startMovementTimer()
        startSpawnTimer()
    }
    
    func stop() {
        movementTimer?.invalidate(); movementTimer = nil
        spawnTimer?.invalidate(); spawnTimer = nil
        fishes.removeAll()
        caughtCount = 0
        isFinished = false
        caughtFish.removeAll()
    }
    
    func onFishingAction() {
        // Try to catch the fish that is horizontally at the screen center
        guard lastWidth > 0, lastHeight > 0 else { return }
        let centerX = lastWidth / 2.0
        let hitHalfWidth: CGFloat = 40
        var bestIndex: Int? = nil
        var bestDx: CGFloat = .greatestFiniteMagnitude
        for (i, fish) in fishes.enumerated() {
            let dx = abs(fish.x - centerX)
            if dx <= hitHalfWidth {
                if dx < bestDx {
                    bestDx = dx
                    bestIndex = i
                }
            }
        }
        if let idx = bestIndex {
            let fish = fishes[idx]
            let roll = Int.random(in: 1...100)
            // Slightly reduce catch chance to increase difficulty
            let catchChance = max(1, Int(Double(fish.type.chanceToCatch) * 0.8))
            if roll <= catchChance {
                fishes.remove(at: idx)
                caughtCount += 1
                caughtFish.append(fish.type)
                showStatusMessage("Caught: \(fish.type.name)!")
                finishIfNeeded()
            } else {
                showStatusMessage("Escaped!")
            }
        } else {
            showStatusMessage("Nothing…")
        }
    }
    
    func setCasting(_ casting: Bool) {
        isCasting = casting
    }

    private func showStatusMessage(_ text: String) {
        statusText = text
        showStatus = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            withAnimation(.easeOut(duration: 0.2)) {
                self?.showStatus = false
            }
        }
    }

    private func finishIfNeeded() {
        if caughtCount >= goalCount {
            isFinished = true
            stopTimersOnly()
        }
    }

    private func stopTimersOnly() {
        movementTimer?.invalidate(); movementTimer = nil
        spawnTimer?.invalidate(); spawnTimer = nil
    }

    func restartGame() {
        isFinished = false
        caughtCount = 0
        caughtFish.removeAll()
        fishes.removeAll()
        startMovementTimer()
        startSpawnTimer()
    }
    
    private func startMovementTimer() {
        movementTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            guard self.lastWidth > 0 else { return }
            // Move fishes left -> right
            for i in self.fishes.indices {
                self.fishes[i].x += self.fishes[i].speed
            }
            // Remove off-screen
            self.fishes.removeAll { $0.x > self.lastWidth + 60 }
        }
        if let movementTimer { RunLoop.main.add(movementTimer, forMode: .common) }
    }
    
    private func startSpawnTimer() {
        // Less frequent spawn for fewer fish
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { [weak self] _ in
            self?.attemptSpawnFish()
        }
        if let spawnTimer { RunLoop.main.add(spawnTimer, forMode: .common) }
    }
    
    private func attemptSpawnFish() {
        guard lastWidth > 0, lastHeight > 0 else { return }
        // Choose random fish and decide spawn by chanceToCatch
        if let fishType = Fish.allCases.randomElement() {
            let roll = Int.random(in: 1...100)
            // Lower spawn chance for fewer fish
            let spawnChance = max(1, Int(Double(fishType.chanceToCatch) * 0.6))
            if roll <= spawnChance {
                let yMin = lastHeight * 0.55
                let yMax = lastHeight * 0.95
                let y = CGFloat.random(in: yMin...yMax)
                let speed = CGFloat.random(in: 1.2...2.8)
                let fish = SwimmingFish(type: fishType, x: -60, y: y, speed: speed)
                fishes.append(fish)
            }
        }
    }
}

//
//  FisingGameViewModel.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 14.10.2025.
//

