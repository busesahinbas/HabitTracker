//
//  DashboardViewController.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private(set) weak var tableView: UITableView!
    
    // MARK: - Properties
    private var progressCell: ProgressTableViewCell?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressView(_:)), name: NSNotification.Name("UpdateProgress"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProgress()
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configuration
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "ProgressTableViewCell")
        tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
        
        tableView.layer.masksToBounds = false
    }
    
    @objc private func updateProgressView(_ notification: Notification) {
        if let progress = notification.object as? CGFloat {
            progressCell?.configure(progress: progress)
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressTableViewCell", for: indexPath) as? ProgressTableViewCell else {
                return UITableViewCell()
            }
            self.progressCell = cell
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as? TodayTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = .clear
    }
}

// MARK: - TodayTableViewCellDelegate
extension DashboardViewController: TodayTableViewCellDelegate {
    func didUpdateTableViewHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func didTableViewCellDelete() {
        updateProgress()
    }
    
    private func updateProgress() {
        let completedCount = HabitManager.shared.habits.filter { $0.isCompleted }.count
        let totalCount = HabitManager.shared.habits.count
        let progress = totalCount == 0 ? 0 : CGFloat(completedCount) / CGFloat(totalCount) * 100
        
        progressCell?.configure(progress: progress)
    }
    
    func didTapShowAllButton() {
        let showAllVC = ShowAllViewController()
        navigationController?.pushViewController(showAllVC, animated: true)
    }
}

// MARK: - UserTableViewCellDelegate
extension DashboardViewController: UserTableViewCellDelegate {
    func didTapAddButton() {
        let createVC = CreateViewController()
        navigationController?.pushViewController(createVC, animated: true)
    }
}
