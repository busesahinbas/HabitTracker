//
//  Constants.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation

import Foundation

struct Habit: Identifiable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var period: Period
    var frequencyType: FrequencyType
    var createdAt: Date
    var completedDates: [Date] // Hangi günler tamamlandı
    
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

// Alışkanlığın tekrar etme süresi
struct Period {
    var ones: Int?
    var weekly: Int?
    var monthly: Int?
    var yearly: Int?
}

// Kullanıcının seçtiği tekrar modeli
enum FrequencyType {
    case everyday
    case weekdays
    case weekends
    case custom([Int]) // Belirli günler için (örn: [1, 3, 5] -> Pazartesi, Çarşamba, Cuma)
}

// Örnek alışkanlıklar
var habits: [Habit] = [
//    Habit(name: "Meditation", isCompleted: true, period: Period(weekly: 5), frequencyType: .weekdays),
    Habit(name: "Read Philosophy", period: Period(monthly: 10), frequencyType: .custom([2, 4, 6])),
    Habit(name: "Journaling", period: Period(weekly: 7), frequencyType: .everyday)
]
