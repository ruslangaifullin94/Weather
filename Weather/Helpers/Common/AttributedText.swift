//
//  AttributedText.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 12.01.2024.
//

import UIKit

@resultBuilder
 struct AttributedStringBuilder {
     static func buildBlock(_ components: [AttributedStringComponent]...) -> [AttributedStringComponent] {
        components.flatMap { $0 }
    }
    
     static func buildExpression(_ expression: [AttributedStringComponent]) -> [AttributedStringComponent] {
        expression
    }
    
     static func buildExpression(_ expression: AttributedStringComponent) -> [AttributedStringComponent] {
        [expression]
    }
    
     static func buildOptional(_ component: [AttributedStringComponent]?) -> [AttributedStringComponent] {
        component ?? []
    }
    
     static func buildEither(first component: [AttributedStringComponent]) -> [AttributedStringComponent] {
        component
    }
    
     static func buildEither(second component: [AttributedStringComponent]) -> [AttributedStringComponent] {
        component
    }
}

 protocol AttributedStringComponent {
    typealias StringComponent = (String, [NSAttributedString.Key: Any])
    
    func getComponent() -> StringComponent
}

 struct AttributedText: AttributedStringComponent {
    private let text: String
    private var attributes = [NSAttributedString.Key: Any]()
    
    
     init(_ text: String) {
        self.text = text
    }
    
     func getComponent() -> StringComponent {
        (text, attributes)
    }
    
     func font(_ font: UIFont) -> Self {
        var mutated = self
        mutated.attributes[.font] = font
        return mutated
    }
    
     func foregroundColor(_ color: UIColor) -> Self {
        var mutated = self
        mutated.attributes[.foregroundColor] = color
        return mutated
    }
}

struct LineBreak: AttributedStringComponent {
    func getComponent() -> StringComponent {
        ("\n", [:])
    }
}

extension NSMutableAttributedString {
    convenience init(@AttributedStringBuilder _ builder: () -> [AttributedStringComponent]) {
        let components = builder().map { $0.getComponent() }
        self.init(string: components.map(\.0).joined())
        var currentLoaction = 0
        components.forEach {
            setAttributes($1, range: NSRange(location: currentLoaction, length: $0.count))
            currentLoaction += $0.count
        }
    }
}
