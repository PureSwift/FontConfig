import Testing
@testable import FontConfig

@Test func testCreateFontPattern() {
    
    #if os(Linux)
    var fontNames = [
        ("LiberationSerif", "Liberation Serif"),
        ("LiberationSerif-Bold", "Liberation Serif")
    ]

    #else
    var fontNames = [
        ("TimesNewRoman", "Times New Roman"),
        ("TimesNewRoman-Bold", "Times New Roman")
    ]
    #endif
    
    #if os(macOS)
    fontNames += [("MicrosoftSansSerif", "Microsoft Sans Serif"),
                  ("MicrosoftSansSerif-Bold", "Microsoft Sans Serif")]
    #endif
    
    for (fontName, expectedFullName) in fontNames {
        
        //let font = #require(Pattern(name: fontName), "Could not create font \(fontName)")
        
        guard let font = Pattern(name: fontName) else {
            #expect(false)
            return
        }
    }
}
