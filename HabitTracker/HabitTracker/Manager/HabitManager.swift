//
//  HabitManager.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 23.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation

class HabitManager {
    static let shared = HabitManager()
    private let habitsKey = "savedHabits"

    private init() {}

    var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }

    // MARK: - CRUD İşlemleri
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }

    func deleteHabit(at index: Int) {
        guard index < habits.count else { return }
        habits.remove(at: index)
    }

    func updateHabit(at index: Int, with updatedHabit: Habit) {
        guard index < habits.count else { return }
        habits[index] = updatedHabit
    }

    // MARK: - Local Storage (UserDefaults)
    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: habitsKey)
        }
    }

    func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: habitsKey),
           let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedData) {
            habits = decodedHabits
        }
    }
}
