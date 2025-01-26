//
//  TodayTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class TodayTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var habits: [Habit] = [
         Habit(name: "Meditating", isCompleted: true),
         Habit(name: "Read Philosophy", isCompleted: true),
         Habit(name: "Journaling", isCompleted: false)
     ]
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TodayItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayItemTableViewCell")
        tableView.isScrollEnabled = false
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        let maxCells = min(habits.count, 3) // Max 3 cell will be shown
        let rowHeight: CGFloat = 66
        tableViewHeightConstraint.constant = CGFloat(maxCells) * rowHeight
        layoutIfNeeded()
    }
}

extension TodayTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayItemTableViewCell", for: indexPath) as? TodayItemTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
