//
//  CacheManager.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

class CacheManager {
    static let shared = CacheManager()
    public let defaults = UserDefaults.standard
}
