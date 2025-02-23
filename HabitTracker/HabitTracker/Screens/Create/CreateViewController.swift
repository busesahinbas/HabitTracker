//
//  CreateViewController.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 16.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var habitNameTextField: UITextField!
    @IBOutlet private weak var periodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "New Habit ✨"
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.1
        
        habitNameTextField.placeholder = "Enter habit name"
        createButton.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    @IBAction private func createButtonTapped(_ sender: UIButton) {
        guard let habitName = habitNameTextField.text, !habitName.isEmpty else {
            showAlert(message: "Please enter a habit name 📝")
            return
        }
        
        let frequencyType: FrequencyType
        switch typeSegmentedControl.selectedSegmentIndex {
        case 0:
            frequencyType = .everyday
        case 1:
            frequencyType = .weekdays
        case 2:
            frequencyType = .weekends
        default:
            frequencyType = .everyday
        }
        
        let period: Period
        switch periodSegmentedControl.selectedSegmentIndex {
        case 0: // Weekly
            period = Period(weekly: 7)
        case 1: // Monthly
            period = Period(monthly: 30)
        case 2: // Yearly
            period = Period(yearly: 1)
        default:
            period = Period(weekly: 7)
        }
        
        let habit = Habit(
            name: habitName,
            period: period,
            frequencyType: frequencyType
        )
        
        HabitManager.shared.addHabit(habit)
        
        // Show success message
        let banner = UIAlertController(title: "Success! 🎉", 
                                     message: "Your new habit '\(habit.name)' has been created!", 
                                     preferredStyle: .alert)
        banner.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(banner, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Oops! 😅", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
