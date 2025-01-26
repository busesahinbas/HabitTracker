//
//  ProgressTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class ProgressTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var backgroundImageView: UIImageView!
    @IBOutlet private(set) weak var progressView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        backgroundImageView.layer.cornerRadius = 7
        
        let circularProgress = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 117, height: 117))
        circularProgress.progress = 70
        progressView.addSubview(circularProgress) // ✅ Doğru kullanım
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
