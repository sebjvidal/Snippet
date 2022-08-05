//
//  IntegerNumberFormatter.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import Cocoa

class SNIntegerNumberFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if partialString.isEmpty {
            return true
        }
        
        return Int(partialString) != nil
    }
}

