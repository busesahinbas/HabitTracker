//
//  TodayItemTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

class TodayItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var habitLabel: UILabel!
    @IBOutlet private weak var checkmarkButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        configure()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    func configure() {
//        if habit.isCompleted {
            containerView.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            checkmarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkmarkButton.tintColor = .green
//        } else {
//            containerView.backgroundColor = .white
//            checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
//            checkmarkButton.tintColor = .black
//        }
    }
}
