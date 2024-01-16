//
//  UIView+Extensions.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation
import UIKit

extension UIView {
    
    static var id: String {
        String(describing: self)
    }
    
    /// Добавление subviews
    /// - Parameters:
    /// - subviews: subviews, которые нужно добавить.
    /// - translatesAutoresizingMaskIntoConstraints: флаг, определяющий будет ли autoresizingMask преобразована в constraints для каждой subview.
    func addSubviews(_ views: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = true) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            self.addSubview($0)
        }
    }
    
    /// Закруглить углы
    /// - Parameters:
    ///   - corners: углы, которые надо закруглить.
    ///   - radius: радиус закругления.
    func makeRoundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    @discardableResult
    func withBackgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    func withBackgroundView(_ insets: UIEdgeInsets) -> UIView {
        UIView()
            .with(\.layoutMargins, setTo: insets)
            .with { view in
                view.addSubview(self)
                self.snp.makeConstraints { $0.edges.equalTo(view.layoutMarginsGuide) }
            }
    }
    
    func withBackgroundView(_ insets: CGFloat) -> UIView {
        withBackgroundView(UIEdgeInsets(floatLiteral: insets))
    }
    
    func withHighHuggingPriority() -> Self {
        self
            .with { $0.setContentHuggingPriority(.required, for: .vertical) }
            .with { $0.setContentHuggingPriority(.required, for: .horizontal) }
    }
    
    func withHighCompressionPriority() -> Self {
        self
            .with { $0.setContentCompressionResistancePriority(.required, for: .vertical) }
            .with { $0.setContentCompressionResistancePriority(.required, for: .horizontal) }
    }
}
