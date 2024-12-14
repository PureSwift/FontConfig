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
    public func set(_ value: String, for key: Key) -> Bool {
        FcPatternAddString(internalPointer, key.rawValue, value) != 0
    }
    
    /// Removes the value associated with the property 'object' at position 'id', returning whether the property existed and had a value at that position or not.
    @discardableResult
    public func remove(_ key: Key, at position: Int32 = 0) -> Bool {
        FcPatternRemove(internalPointer, key.rawValue, position) != 0
    }
    
    @discardableResult
    public func get(_ key: Key) -> String? {
        var cString: UnsafeMutablePointer<UInt8>?
        guard FcPatternGetString(internalPointer, key.rawValue, 0, &cString) == FcResultMatch else {
            return nil
        }
        return String(cString: cString!)
    }
    
    @discardableResult
    public func set(_ value: Int32, for key: Key) -> Bool {
        FcPatternAddInteger(internalPointer, key.rawValue, value) != 0
    }
}

// MARK: - Equatable

extension Pattern: Equatable {
    
    public static func == (lhs: Pattern, rhs: Pattern) -> Bool {
        FcPatternEqual(lhs.internalPointer, rhs.internalPointer) != 0
    }
}

// MARK: - Hashable

extension Pattern: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        let hashValue = FcPatternHash(internalPointer)
        hasher.combine(hashValue)
    }
}

// MARK: - Accessors

public extension Pattern {
    
    var family: String? {
        get {
            get(.family)
        }
        set {
            if let newValue {
                set(newValue, for: .family)
            } else {
                remove(.family)
            }
        }
    }
}

// MARK: - Supporting Types

public extension Pattern {
    
    struct Key: RawRepresentable, Hashable, Sendable {
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        private init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
    }
}

extension Pattern.Key: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension Pattern.Key: CustomStringConvertible {
    
    public var description: String {
        rawValue
    }
}

public extension Pattern.Key {
    
    static var family: Pattern.Key { .init(FC_FAMILY) }
}
