//
//  FontConfig.swift
//  FontConfig
//
//  Created by Alsey Coleman Miller on 12/14/24.
//

import CFontConfig

public final class FontConfiguration {
    
    internal let internalPointer: OpaquePointer // FcConfig
    
    // MARK: Initialization
    
    deinit {
        FcConfigDestroy(internalPointer)
    }
    
    public init() {
        self.internalPointer = FcConfigCreate()
    }
    
    internal init(_ pointer: OpaquePointer) {
        self.internalPointer = pointer
    }
    
    public static var current: FontConfiguration {
        get {
            self.init(FcConfigGetCurrent())
        }
        set {
            FcConfigSetCurrent(newValue.internalPointer)
        }
    }
    
    // MARK: Methods
    
    public func substitute(pattern: Pattern, with otherPattern: Pattern? = nil, kind: FcMatchKind) {
        FcConfigSubstituteWithPat(internalPointer, pattern.internalPointer, otherPattern?.internalPointer, kind)
    }
    
    /// Finds the font in sets most closely matching pattern and returns the result of FcFontRenderPrepare for that font and the provided pattern.
    /// This function should be called only after FcConfigSubstitute and FcDefaultSubstitute have been called for p; otherwise the results will not be correct.
    public func match(_ pattern: Pattern) -> FcResult {
        var result = FcResult(0)
        FcFontMatch(internalPointer, pattern.internalPointer, &result)
        return result
    }
}
