//
//  UIEdgeInsets.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 12.01.2024.
//

import UIKit

extension UIEdgeInsets: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(
            top: CGFloat(value),
            left: CGFloat(value),
            bottom: CGFloat(value),
            right: CGFloat(value)
        )
    }
}

extension UIEdgeInsets: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(
            top: CGFloat(value),
            left: CGFloat(value),
            bottom: CGFloat(value),
            right: CGFloat(value)
        )
    }
    
    static public func equal(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(floatLiteral: inset)
    }
}

extension UIEdgeInsets {
    enum Edge {
        case left
        case right
        case top
        case bottom
        case all
    }
    
    init(edges: Edge..., inset: CGFloat, `default` value: CGFloat = 0) {
        var left: CGFloat = value
        var right: CGFloat = value
        var top: CGFloat = value
        var bottom: CGFloat = value
        
        edges.forEach {
            switch $0 {
            case .left:
                left = inset
            case .right:
                right = inset
            case .top:
                top = inset
            case .bottom:
                bottom = inset
            case .all:
                left = inset
                right = inset
                top = inset
                bottom = inset
            }
        }
        
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func edges(edges: Edge..., inset: CGFloat, `default` value: CGFloat = 0) -> UIEdgeInsets {
        var left: CGFloat = value
        var right: CGFloat = value
        var top: CGFloat = value
        var bottom: CGFloat = value
        
        edges.forEach {
            switch $0 {
            case .left:
                left = inset
            case .right:
                right = inset
            case .top:
                top = inset
            case .bottom:
                bottom = inset
            case .all:
                left = inset
                right = inset
                top = inset
                bottom = inset
            }
        }
        
        return self.init(top: top, left: left, bottom: bottom, right: right)
    }
}

