//
//  CACornerMask+EXtension.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit

extension CACornerMask {
    
    /// Правый верхний угол
    public static let topRight: CACornerMask = .layerMaxXMinYCorner
    
    /// Правый нижний угол
    public static let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    
    /// Левый верхний угол
    public static let topLeft: CACornerMask = .layerMinXMinYCorner
    
    /// Левый нижний угол
    public static let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    
    /// Верхние углы
    public static let top: CACornerMask = [.topLeft, .topRight]
    
    /// Нижние углы
    public static let bottom: CACornerMask = [.bottomLeft, .bottomRight]
    
    /// Левые углы
    public static let left: CACornerMask = [.topLeft, .bottomLeft]
    
    /// Правые углы
    public static let right: CACornerMask = [.topRight, .bottomRight]
    
    /// Все углы
    public static let all: CACornerMask = [.top, .bottom]
}
