import Testing
@testable import FontConfig

@Test func testCreateFontPattern() {
    
    #if os(Linux)
    var fontNames = [
        ("LiberationSerif", "LiberationSerif"),
        ("LiberationSerif-Bold", "LiberationSerif")
    ]

    #else
    var fontNames = [
        ("TimesNewRoman", "TimesNewRoman"),
        ("TimesNewRoman-Bold", "TimesNewRoman")
    ]
    #endif
    
    #if os(macOS)
    fontNames += [("MicrosoftSansSerif", "MicrosoftSansSerif"),
                  ("MicrosoftSansSerif-Bold", "MicrosoftSansSerif")]
    #endif
    
    for (name, family) in fontNames {
        
        //let font = #require(Pattern(name: fontName), "Could not create font \(fontName)")
        
        guard let pattern = Pattern(name: name) else {
            #expect(Bool(false))
            return
        }
        
        #expect(pattern.family == family)
        #expect(pattern.weight == nil)
    }
}
