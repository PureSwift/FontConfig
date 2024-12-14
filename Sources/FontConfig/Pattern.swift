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
    public func setString(_ value: String, for key: Key) -> Bool {
        FcPatternAddString(internalPointer, key.rawValue, value) != 0
    }
    
    /// Removes the value associated with the property 'object' at position 'id', returning whether the property existed and had a value at that position or not.
    @discardableResult
    public func remove(_ key: Key, at position: Int32 = 0) -> Bool {
        FcPatternRemove(internalPointer, key.rawValue, position) != 0
    }
    
    @discardableResult
    public func string(for key: Key, at position: Int32 = 0) -> String? {
        var cString: UnsafeMutablePointer<UInt8>?
        guard FcPatternGetString(internalPointer, key.rawValue, position, &cString) == FcResultMatch else {
            return nil
        }
        return String(cString: cString!)
    }
    
    @discardableResult
    public func setInteger(_ value: Int32, for key: Key) -> Bool {
        FcPatternAddInteger(internalPointer, key.rawValue, value) != 0
    }
    
    @discardableResult
    public func integer(for key: Key, at position: Int32 = 0) -> Int32? {
        var intValue: Int32 = 0
        guard FcPatternGetInteger(internalPointer, key.rawValue, position, &intValue) == FcResultMatch else {
            return nil
        }
        return intValue
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
            string(for: .family)
        }
        set {
            if let newValue {
                remove(.family)
                setString(newValue, for: .family)
            } else {
                remove(.family)
            }
        }
    }
    
    var weight: FontWeight? {
        get {
            guard let weightValue = integer(for: .weight),
                let weight = FontWeight(rawValue: weightValue) else {
                return nil
            }
            return weight
        }
        set {
            if let newValue {
                remove(.weight)
                setInteger(newValue.rawValue, for: .weight)
            } else {
                remove(.weight)
            }
        }
    }
    
    /// Font slant
    var slant: FontSlant? {
        get {
            guard let rawValue = integer(for: .slant),
                  let slant = FontSlant(rawValue: rawValue) else {
                return nil
            }
            return slant
        }
        set {
            if let newValue {
                remove(.slant)
                setInteger(newValue.rawValue, for: .slant)
            } else {
                remove(.slant)
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
    
    static var weight: Pattern.Key { .init(FC_WEIGHT) }
    
    static var slant: Pattern.Key { .init(FC_SLANT) }
    
    static var width: Pattern.Key { .init(FC_WIDTH) }
}
