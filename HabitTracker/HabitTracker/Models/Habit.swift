//
//  Habit.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 23.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var period: Period
    var frequencyType: FrequencyType
    var createdAt: Date
    var completedDates: [Date]

    init(name: String, isCompleted: Bool = false, period: Period, frequencyType: FrequencyType) {
        self.id = UUID()
        self.name = name
        self.isCompleted = isCompleted
        self.period = period
        self.frequencyType = frequencyType
        self.createdAt = Date()
        self.completedDates = []
    }

    mutating func toggleCompletion(for date: Date = Date()) {
        if completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            completedDates.removeAll { Calendar.current.isDate($0, inSameDayAs: date) }
        } else {
            completedDates.append(date)
        }
        isCompleted = !completedDates.isEmpty
    }
}

struct Period: Codable {
    var ones: Int?
    var weekly: Int?
    var monthly: Int?
    var yearly: Int?
}

enum FrequencyType: Codable {
    case everyday
    case weekdays
    case weekends
    case custom([Int])
}
