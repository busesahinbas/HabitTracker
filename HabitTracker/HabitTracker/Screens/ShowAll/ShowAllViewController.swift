//
//  ShowAllViewController.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 16.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class ShowAllViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private(set) weak var tableView: UITableView!
  
    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    //MARK: - Setup Configuration
    private func setupUI() {
        title = "All Habits"
        tableView.roundCorners()
        tableView.addShadow()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TodayItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayItemTableViewCell")
        tableView.isScrollEnabled = false
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ShowAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayItemTableViewCell", for: indexPath) as? TodayItemTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(habit: habits[indexPath.row])
        return cell
    }
}
