//
//  With.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import Foundation
import struct UIKit.NSDiffableDataSourceSnapshot

 protocol WithObject {
    associatedtype T

    @discardableResult
    func with(_ closure: (_ instance: T) -> Void) -> T
}

 extension WithObject where Self: AnyObject {
    @discardableResult
    func with(_ closure: (_ instance: Self) -> Void) -> Self {
        closure(self)
        return self
    }

    @discardableResult
    func with<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}

 protocol WithValue {
    @discardableResult
    func with(_ closure: (_ instance: inout Self) -> Void) -> Self
}

 extension WithValue {
    @discardableResult
    func with(_ closure: (_ instance: inout Self) -> Void) -> Self {
        var mutated = self
        closure(&mutated)
        return mutated
    }
}

extension NSObject: WithObject { }
extension JSONDecoder: WithObject { }
extension JSONEncoder: WithObject { }
extension NSDiffableDataSourceSnapshot: WithValue {}

