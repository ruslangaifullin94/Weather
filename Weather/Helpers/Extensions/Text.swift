//
//  Text.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import UIKit

fileprivate extension NSAttributedString {
    
    var fullRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
    
    func stringByAddingAttribute(
        _ key: NSAttributedString.Key,
        value: Any,
        in range: NSRange? = nil) -> NSAttributedString {
            let range = range ?? fullRange
            
            return NSMutableAttributedString(attributedString: self)
                .with { $0.addAttribute(key, value: value, range: range) }
        }
}


enum Fonts {
    enum Rubik {
        static let regular: UIFont = UIFont(name: "Rubik-Regular", size: 12)!
        static let medium: UIFont = UIFont(name: "Rubik-Medium", size: 12)!
    }
}

extension UIFont {
    static func rubik(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .regular:
            return Fonts.Rubik.regular.withSize(size)
        case .medium:
            return Fonts.Rubik.medium.withSize(size)
        default:
            return Fonts.Rubik.regular.withSize(size)
        }
    }
}


extension UILabel {
    
    @discardableResult
    func withLineHeight(_ height: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = height
        paragraphStyle.minimumLineHeight = height
        return self.addingAttribute(.paragraphStyle, value: paragraphStyle)
    }
    
    @discardableResult
    func addingAttribute(
        _ key: NSAttributedString.Key,
        value: Any,
        in range: NSRange? = nil
    ) -> Self {
        guard let attributedText = attributedText else {
            attributedText = NSAttributedString(string: " ", attributes: [key: value])
            return self
        }
        let range = range ?? attributedText.fullRange
        self.attributedText = attributedText.stringByAddingAttribute(key, value: value, in: range)
        return self
    }
    
    var baseStyle: UILabel {
        self
            .with(\.numberOfLines, setTo: .zero)
            .with(\.textColor, setTo: UIColor(named: "mainTextColor"))
            .with(\.font, setTo: .rubik(size: 16, weight: .regular))
    }
    
    var centered: UILabel {
        with(\.textAlignment, setTo: .center)
    }
    
    @discardableResult
    func withTextColor(_ color: UIColor) -> UILabel {
        with(\.textColor, setTo: color)
    }
}

extension UILabel {
    var text1: UILabel {
        baseStyle
            .withLineHeight(20)
            .with(\.font, setTo: .rubik(size: 16, weight: .regular))
    }
    
    var text2: UILabel {
        baseStyle
            .withLineHeight(18)
            .with(\.font, setTo: .rubik(size: 14, weight: .regular))
    }
    
    var text3: UILabel {
        baseStyle
            .withLineHeight(40)
            .with(\.font, setTo: .rubik(size: 36, weight: .medium))
    }
    
    var text4: UILabel {
        baseStyle
            .withLineHeight(22)
            .with(\.font, setTo: .rubik(size: 18, weight: .medium))
    }
    
}
