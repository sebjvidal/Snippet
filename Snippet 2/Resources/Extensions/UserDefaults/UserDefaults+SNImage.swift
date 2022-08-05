//
//  UserDefaults+SNImage.swift
//  Snippet
//
//  Created by Seb Vidal on 27/07/2022.
//

import Cocoa

extension UserDefaults {
    func image(forKey key: String) -> SNImage? {
        if let data = data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let image = try decoder.decode(SNImage.self, from: data)
                
                return image
            } catch {
                print("UserDefaults: Error while decoding SNImage.")
            }
        }
        
        return nil
    }
    
    func set(_ image: SNImage, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(image)
            
            set(data, forKey: key)
        } catch {
            print("UserDefaults: Error while encoding SNImage.")
        }
    }
}
