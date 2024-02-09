//
//  ShimmeringView.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 13.01.2024.
//

import UIKit

class ShimmeringView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.clear
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        startShimmering()
    }

    func startShimmering() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = Float.infinity
        animation.duration = 1.5 // Adjust the duration based on your preference
        gradientLayer.add(animation, forKey: "shimmer")
    }

    func stopShimmering() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}
