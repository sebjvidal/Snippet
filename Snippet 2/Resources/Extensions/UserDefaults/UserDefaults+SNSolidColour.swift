//
//  UserDefaults+SNSolidColour.swift
//  Snippet
//
//  Created by Seb Vidal on 27/07/2022.
//

import Cocoa

extension UserDefaults {
    func solidColour(forKey key: String) -> SNSolidColour? {
        if let data = data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let solidColour = try decoder.decode(SNSolidColour.self, from: data)
                
                return solidColour
            } catch {
                print("UserDefaults: Error while decoding SNSolidColour.")
            }
        }
        
        return nil
    }
    
    func set(_ solidColour: SNSolidColour, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(solidColour)
            
            set(data, forKey: key)
        } catch {
            print("UserDefaults: Error while encoding SNSolidColour.")
        }
    }
}

