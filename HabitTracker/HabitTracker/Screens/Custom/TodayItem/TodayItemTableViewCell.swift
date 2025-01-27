//
//  TodayItemTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

protocol TodayItemTableViewCellDelegate: AnyObject {
    func didToggleHabitCompletion(for cell: TodayItemTableViewCell)
}

class TodayItemTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private weak var habitLabel: UILabel!
    @IBOutlet private weak var checkmarkButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    //MARK: - Properties
    weak var delegate: TodayItemTableViewCellDelegate?
    private var habit: Habit?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI Configuration
    private func setupUI() {
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    //MARK: - Public Methods
    func configure(habit: Habit?) {
        guard let habit = habit else { return }
        self.habit = habit
        configureColor(isCompleted: habit.isCompleted)
        habitLabel.text = habit.name
    }
    
    //MARK: - Private Methods
    private func configureColor(isCompleted: Bool) {
        if isCompleted {
            containerView.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            checkmarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkmarkButton.tintColor = .green
        } else {
            containerView.backgroundColor = .white
            checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            checkmarkButton.tintColor = .black
        }
    }
    
    //MARK: - Actions
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
        guard var habit = habit else { return }
        
        habit.isCompleted.toggle()
        self.habit = habit
        
        configureColor(isCompleted: habit.isCompleted)
        
        delegate?.didToggleHabitCompletion(for: self)
    }
}
