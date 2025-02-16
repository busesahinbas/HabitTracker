//
//  TableView+Extensions.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 16.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Rounds the corners of the view with a given radius.
    func roundCorners(radius: CGFloat = 6) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false // allow shadow to be visible
    }
    
    /// Adds a shadow to the view with customizable properties.
    func addShadow(color: UIColor = .black,
                   offset: CGSize = CGSize(width: 0, height: 2),
                   opacity: Float = 0.2,
                   radius: CGFloat = 6) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
