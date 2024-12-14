//
//  Pattern.swift
//  FontConfig
//
//  Created by Alsey Coleman Miller on 12/13/24.
//

import CFontConfig

/// FontConfig Pattern
public final class Pattern {
    
    // MARK: - Properties
    
    internal let internalPointer: OpaquePointer
    
    // MARK: - Initialization
    
    deinit {
        FcPatternDestroy(internalPointer)
    }
    
    public init() {
        self.internalPointer = FcPatternCreate()
    }
    
    public init?(name: String) {
        guard let pointer = FcNameParse(name) else {
            return nil
        }
        self.internalPointer = pointer
    }
    
    // MARK: - Methods
    
    @discardableResult
    public func set(_ value: String, for key: String) -> Bool {
        FcPatternAddString(internalPointer, key, value) != 0
    }
    
    @discardableResult
    public func set(_ value: Int32, for key: String) -> Bool {
        FcPatternAddInteger(internalPointer, key, value) != 0
    }
}
