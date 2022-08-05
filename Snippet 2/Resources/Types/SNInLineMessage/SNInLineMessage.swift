//
//  SNInLineMessage.swift
//  Snippet
//
//  Created by Seb Vidal on 04/08/2022.
//

import Cocoa

class SNInLineMessage: Codable {
    var line: Int = 1
    var type: MessageType = .warning
    var text: String = "Warning!"
    
    init(line: Int, type: MessageType, text: String) {
        self.line = line
        self.type = type
        self.text = text
    }
}

extension SNInLineMessage {
    enum MessageType: String, Codable {
        case warning = "Warning"
        case thread = "Thread Warning"
        case error = "Fixable Error"
        case crash = "Unfixable Error"
        case info = "Information"
        case `break` = "Breakpoint"
    }
}
