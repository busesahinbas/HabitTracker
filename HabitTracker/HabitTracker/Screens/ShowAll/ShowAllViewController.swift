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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
       private var days: [Date] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupCollectionView()
        setupNavigationBar()
        loadDays()
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
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 50, height: 50)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
    }
    
    private func loadDays() {
        days = CalendarManager.shared.getDaysForNextMonths(months: 3)
        collectionView.reloadData()
    }
    
    private func setupEmptyState() {
        emptyAnimationView.animation = LottieAnimation.named("empty-habits")
        emptyAnimationView.loopMode = .loop
        emptyAnimationView.play()
    }
    
    private func updateUI() {
        tableView.reloadData()
        emptyView.isHidden = !HabitManager.shared.habits.isEmpty
        tableView.isHidden = HabitManager.shared.habits.isEmpty
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
        return HabitManager.shared.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodayItemTableViewCell", for: indexPath) as? TodayItemTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(habit: HabitManager.shared.habits[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - TodayItemTableViewCellDelegate
extension ShowAllViewController: TodayItemTableViewCellDelegate {
    func didToggleHabitCompletion(for cell: TodayItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        HabitManager.shared.habits[indexPath.row].toggleCompletion()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // Update dashboard progress
        let completedCount = HabitManager.shared.habits.filter { $0.isCompleted }.count
        let totalCount = HabitManager.shared.habits.count
        let progress = totalCount == 0 ? 0 : CGFloat(completedCount) / CGFloat(totalCount) * 100
        NotificationCenter.default.post(name: NSNotification.Name("UpdateProgress"), object: progress)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ShowAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        let date = days[indexPath.item]
        cell.configure(with: date, isSelected: true)
        return cell
    }
}
