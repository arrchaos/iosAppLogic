//
//  Command.swift
//
//  Created by Илья on 21.02.2023.
//

import Foundation

open class Command {
    
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    open func perform() {
        action()
    }
}

open class CommandWith<T> {
    
    private let action: (T) -> Void
    
    public init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    open func perform(with value: T) {
        action(value)
    }
}
