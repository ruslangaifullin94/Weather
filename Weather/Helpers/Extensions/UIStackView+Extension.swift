//
//  UIStackView+Extension.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit

public extension UIStackView {
    func horizontal(spacing: CGFloat = 0) -> Self {
        with {
            $0.axis = .horizontal
            $0.spacing = spacing
        }
    }
    
    func vertical(spacing: CGFloat = 0) -> Self {
        with {
            $0.axis = .vertical
            $0.spacing = spacing
        }
    }
    
    func views(_ views: UIView ...) -> Self {
        views.forEach { self.addArrangedSubview($0) }
        return self
    }
    
    func views(@StackViewBuilder _ builder: () -> [UIView]) -> Self {
        builder().forEach { addArrangedSubview($0) }
        return self
    }
}

@resultBuilder
public struct StackViewBuilder {
    public static func buildBlock(_ components: UIView...) -> [UIView] {
        components
    }
    
    public static func buildBlock(_ components: [UIView]) -> [UIView] {
        components
    }
    
    public static func buildPartialBlock(accumulated: [UIView], next: [UIView]) -> [UIView] {
        accumulated + next
    }
}
