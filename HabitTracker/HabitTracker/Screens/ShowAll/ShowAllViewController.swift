//
//  ShowAllViewController.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 16.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit
import Lottie

final class ShowAllViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var emptyView: UIView!
    @IBOutlet private weak var emptyAnimationView: LottieAnimationView!
    
    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    //MARK: - Setup Configuration
    private func setupUI() {
        title = "All Habits"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.roundCorners()
        tableView.addShadow()
        tableView.rowHeight = 66
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        setupEmptyState()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TodayItemTableViewCell", bundle: nil), 
                         forCellReuseIdentifier: "TodayItemTableViewCell")
        tableView.isScrollEnabled = true
    }
    
    private func setupEmptyState() {
        emptyAnimationView.animation = LottieAnimation.named("empty-habits")
        emptyAnimationView.loopMode = .loop
        emptyAnimationView.play()
    }
    
    private func updateUI() {
        tableView.reloadData()
        emptyView.isHidden = !habits.isEmpty
        tableView.isHidden = habits.isEmpty
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped() {
        let createVC = CreateViewController()
        navigationController?.pushViewController(createVC, animated: true)
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
        cell.delegate = self
        return cell
    }
}

// MARK: - TodayItemTableViewCellDelegate
extension ShowAllViewController: TodayItemTableViewCellDelegate {
    func didToggleHabitCompletion(for cell: TodayItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        habits[indexPath.row].toggleCompletion()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // Update dashboard progress
        let completedCount = habits.filter { $0.isCompleted }.count
        let totalCount = habits.count
        let progress = totalCount == 0 ? 0 : CGFloat(completedCount) / CGFloat(totalCount) * 100
        NotificationCenter.default.post(name: NSNotification.Name("UpdateProgress"), object: progress)
    }
}
