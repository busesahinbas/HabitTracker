//
//  CircularProgressView.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class CircularProgressView: UIView {
    //MARK: - IBOutlets
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var progressLabel = UILabel()

    //MARK: - Properties
    var progress: CGFloat = 0 {
        didSet {
            setProgress(value: progress)
        }
    }

    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    //MARK: - Setup Configuration
    private func setupView() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        subviews.forEach { $0.removeFromSuperview() }
        
        createTrackLayer()
        createProgressLayer()
        createLabel()
        setupProgress()
    }
    
    private func setupProgress() {
        let completedCount = HabitManager.shared.habits.filter { $0.isCompleted }.count
        let totalCount = HabitManager.shared.habits.count
        let progress = totalCount == 0 ? 0 : CGFloat(completedCount) / CGFloat(totalCount) * 100
        
        setProgress(value: progress)
    }

    private func createTrackLayer() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                        radius: bounds.width / 2,
                                        startAngle: -(.pi / 2),
                                        endAngle: 1.5 * .pi,
                                        clockwise: true)

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round

        layer.addSublayer(trackLayer)
    }

    private func createProgressLayer() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                        radius: bounds.width / 2,
                                        startAngle: -(.pi / 2),
                                        endAngle: 1.5 * .pi,
                                        clockwise: true)

        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0

        layer.addSublayer(progressLayer)
    }

    private func createLabel() {
        progressLabel = UILabel(frame: bounds)
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.boldSystemFont(ofSize: 24)
        progressLabel.textColor = .white
        addSubview(progressLabel)
    }

    func setProgress(value: CGFloat) {
        let newValue = max(0, min(100, value))
        
        progressLayer.strokeEnd = newValue / 100
        progressLabel.text = "\(Int(newValue))%"
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = newValue / 100
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "progressAnim")
    }
}
