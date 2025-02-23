//
//  CalendarCollectionViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 23.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CalendarCollectionViewCell
class CalendarCollectionViewCell: UICollectionViewCell {
    private let dayLabel = UILabel()
    private let monthLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        dayLabel.textAlignment = .center
        dayLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        monthLabel.textAlignment = .center
        monthLabel.font = .systemFont(ofSize: 12, weight: .medium)
        monthLabel.textColor = .darkGray
        
        let stackView = UIStackView(arrangedSubviews: [dayLabel, monthLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6
    }
    
    func configure(with date: Date, isSelected: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dayLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: date).uppercased()
        
        contentView.layer.borderWidth = isSelected ? 2 : 0
        contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
        contentView.backgroundColor = isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : UIColor.systemGray6
    }
}
