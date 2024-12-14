//
//  FontWeight.swift
//  FontConfig
//
//  Created by Alsey Coleman Miller on 12/14/24.
//

/// FontConfig Weight
public enum FontWeight: Int32 {
    
        /// Thin font weight (0).
       case thin = 0
       
       /// Extra light font weight (40).
       case extraLight = 40
       
       /// Light font weight (50).
       case light = 50
       
       /// Demi light font weight (55).
       case demiLight = 55
       
       /// Book font weight (75).
       case book = 75
       
       /// Regular font weight (80).
       case regular = 80
       
       /// Medium font weight (100).
       case medium = 100
       
       /// Demi bold font weight (180).
       case demiBold = 180
       
       /// Bold font weight (200).
       case bold = 200
       
       /// Extra bold font weight (205).
       case extraBold = 205
       
       /// Black font weight (210).
       case black = 210
       
       /// Extra black font weight (215).
       case extraBlack = 215
              
       /// Ultra light font weight, same as extra light (40).
       public static var ultraLight: FontWeight { .extraLight }
       
       /// Semi light font weight, same as demi light (55).
       public static var semiLight: FontWeight { .demiLight }
       
       /// Normal font weight, same as regular (80).
       public static var normal: FontWeight { .regular }
       
       /// Semi bold font weight, same as demi bold (180).
       public static var semiBold: FontWeight { .demiBold }
       
       /// Ultra bold font weight, same as extra bold (205).
       public static var ultraBold: FontWeight { .extraBold }
       
       /// Heavy font weight, same as black (210).
       public static var heavy: FontWeight { .black }
}
