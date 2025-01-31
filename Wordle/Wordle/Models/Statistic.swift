//
//  Statistic.swift
//  Wordle
//
//  Created by Justin Gothard on 2024-06-06.
//

import Foundation

struct Statistic: Codable {
    var frequencies = [Int](repeating: 0, count: 6)
    var games = 0
    var streak = 0
    var maxStreak = 0
    
    var wins: Int {
        frequencies.reduce(0, +)
    }
    
    func saveStat() {
//        if let encoded = try? JSONEncoder().encode(self) {
//            UserDefaults.standard.set(encoded, forKey: "Stat")
//        }
        NSUbiquitousKeyValueStore.stat = self
    }
    static func loadStat() -> Statistic {
//        if let savedStat = UserDefaults.standard.object(forKey: "Stat") as? Data {
//            if let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) {
//                return currentStat
//            } else {
//                return Statistic()
//            }
//        } else {
//            return Statistic()
//        }
        NSUbiquitousKeyValueStore.stat
    }
    
    mutating func update(win: Bool, index: Int? = nil) {
        games += 1
        streak = win ? streak + 1 : 0
        if win {
            frequencies[index!] += 1
            maxStreak = max(maxStreak, streak)
        }
        saveStat()
    }
}
