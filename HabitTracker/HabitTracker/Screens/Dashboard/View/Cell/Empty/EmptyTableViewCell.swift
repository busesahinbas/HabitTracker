//
//  EmptyTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 23.02.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit
import Lottie

final class EmptyTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK: - Setup Configuration
    func setup() {
        lottieView.animation = LottieAnimation.named("empty-habits")
        lottieView.loopMode = .loop
        lottieView.play()
    }
}
