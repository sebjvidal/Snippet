//
//  UserDefaults+SNAspectRatio.swift
//  Snippet
//
//  Created by Seb Vidal on 31/07/2022.
//

import Cocoa

extension UserDefaults {
    func aspectRatio(forKey key: String) -> SNAspectRatio? {
        if let data = data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let image = try decoder.decode(SNAspectRatio.self, from: data)
                
                return image
            } catch {
                print("UserDefaults: Error while decoding SNAspectRatio.")
            }
        }
        
        return nil
    }
    
    func set(_ aspectRatio: SNAspectRatio, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(aspectRatio)
            
            set(data, forKey: key)
        } catch {
            print("UserDefaults: Error while encoding SNAspectRatio.")
        }
    }
}
