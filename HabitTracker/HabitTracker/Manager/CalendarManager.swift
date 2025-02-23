//
//  CalendarManager.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 23.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    private let calendar = Calendar.current
    
    func getDaysForNextMonths(months: Int) -> [Date] {
        guard let startDate = calendar.date(byAdding: .day, value: -calendar.component(.day, from: Date()) + 1, to: Date()) else { return [] }
        
        var days: [Date] = []
        for i in 0..<(months * 30) { // Yaklaşık olarak 3 ayın günlerini hesaplıyoruz
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                days.append(date)
            }
        }
        return days
    }
}
