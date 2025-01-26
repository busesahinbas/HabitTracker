//
//  CircularProgressView.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 26.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

final class CircularProgressView: UIView {
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var progressLabel = UILabel()

    var progress: CGFloat = 0 {
        didSet {
            setProgress(value: progress)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        createTrackLayer()
        createProgressLayer()
        createLabel()
    }

    private func createTrackLayer() {
        let circularPath = UIBezierPath(arcCenter: center,
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
        let circularPath = UIBezierPath(arcCenter: center,
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

    private func setProgress(value: CGFloat) {
        progressLayer.strokeEnd = value / 100
        progressLabel.text = "\(Int(value))%"
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value / 100
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "progressAnim")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
}
