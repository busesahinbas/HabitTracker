//
//  ProgressTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class ProgressTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private(set) weak var backgroundImageView: UIImageView!
    @IBOutlet private(set) weak var progressView: UIView!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    
    //MARK: - Properties
    private var circularProgress: CircularProgressView?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK: - Setup Configuration
    private func setup() {
        backgroundImageView.layer.cornerRadius = 7
        
        circularProgress = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 117, height: 117))
        if let circularProgress = circularProgress {
            progressView.addSubview(circularProgress)
        }
        setupLabel()
    }
    
    func configure(progress: CGFloat) {
        circularProgress?.setProgress(value: progress)
        setupLabel()
    }
    
    private func setupLabel() {
        let completedCount = habits.filter { $0.isCompleted }.count
        let totalCount = habits.count
        
        descriptionLabel.text = "\(completedCount) of \(totalCount) habits completed today!"
    }
}
