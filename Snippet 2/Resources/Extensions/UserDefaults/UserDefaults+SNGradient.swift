//
//  UserDefaults+SNGradient.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import Cocoa

extension UserDefaults {
    func gradient(forKey key: String) -> SNGradient? {
        if let data = data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let gradient = try decoder.decode(SNGradient.self, from: data)
                
                return gradient
            } catch {
                print("UserDefaults: Error while decoding SNGradient.")
            }
        }
        
        return nil
    }
    
    func set(_ gradient: SNGradient, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(gradient)
            
            set(data, forKey: key)
        } catch {
            print("UserDefaults: Error while encoding SNGradient.")
        }
    }
}
