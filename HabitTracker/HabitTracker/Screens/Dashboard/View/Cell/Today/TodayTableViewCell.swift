//
//  TodayTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

protocol TodayTableViewCellDelegate: AnyObject {
    func didUpdateTableViewHeight()
    func didTableViewCellDelete()
    func didTapShowAllButton()
}

final class TodayTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    weak var delegate: TodayTableViewCellDelegate?

    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        
        self.roundCorners()
        self.addShadow()
    }
    
    //MARK: - Setup Configuration
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TodayItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayItemTableViewCell")
        tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        tableView.isScrollEnabled = false
        
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        let rowHeight: CGFloat = habits.isEmpty ? 150 : 66
        let shownCellsCount = habits.isEmpty ? 1 : min(habits.count, 3)
        
        tableViewHeightConstraint.constant = CGFloat(shownCellsCount) * rowHeight
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        delegate?.didUpdateTableViewHeight()
    }
    
    @IBAction func allButtonTapped(_ sender: Any) {
        delegate?.didTapShowAllButton()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension TodayTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return habits.isEmpty ? 1 : habits.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if habits.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard indexPath.row < habits.count, let cell = tableView.dequeueReusableCell(withIdentifier: "TodayItemTableViewCell", for: indexPath) as? TodayItemTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(habit: habits[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !habits.isEmpty, indexPath.row < habits.count else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            habits.remove(at: indexPath.row)
            
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
                if habits.isEmpty {
                    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                }
            }, completion: { _ in
                self.updateTableViewHeight()
                self.updateProgress()
                self.delegate?.didTableViewCellDelete()
            })
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - TodayItemTableViewCellDelegate
extension TodayTableViewCell: TodayItemTableViewCellDelegate {
    func didToggleHabitCompletion(for cell: TodayItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        habits[indexPath.row].toggleCompletion()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        updateProgress()
    }
    
    private func updateProgress() {
        let completedCount = habits.filter { $0.isCompleted }.count
        let totalCount = habits.count
        let progress = totalCount == 0 ? 0 : CGFloat(completedCount) / CGFloat(totalCount) * 100
        
        NotificationCenter.default.post(name: NSNotification.Name("UpdateProgress"), object: progress)
    }
}
