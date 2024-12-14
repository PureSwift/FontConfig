import Testing
@testable import FontConfig

@Test func testCreateFontPattern() {
    
    #if os(Linux)
    var fontNames = [
        ("LiberationSerif", "LiberationSerif", false),
        ("LiberationSerif-Bold", "LiberationSerif", true)
    ]

    #else
    var fontNames = [
        ("TimesNewRoman", "TimesNewRoman", false),
        ("TimesNewRoman-Bold", "TimesNewRoman", true)
    ]
    #endif
    
    #if os(macOS)
    fontNames += [("MicrosoftSansSerif", "MicrosoftSansSerif", false),
                  ("MicrosoftSansSerif-Bold", "MicrosoftSansSerif", true)]
    #endif
    
    for (name, family, isBold) in fontNames {
        
        //let font = #require(Pattern(name: fontName), "Could not create font \(fontName)")
        
        guard let pattern = Pattern(name: name) else {
            #expect(Bool(false))
            return
        }
        
        #expect(pattern.family == family)
    }
}
