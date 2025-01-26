//
//  Constants.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation

struct Habit {
    let name: String
    var isCompleted: Bool
}

private var habits: [Habit] = [
    Habit(name: "Meditating", isCompleted: true),
    Habit(name: "Read Philosophy", isCompleted: true),
    Habit(name: "Journaling", isCompleted: false)
]
