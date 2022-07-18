//
//  UserDefaults+KeyExists.swift
//  Snippet
//
//  Created by Seb Vidal on 29/06/2022.
//

import Cocoa

extension UserDefaults {
    func keyExists(key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
