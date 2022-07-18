//
//  CAGradientLayer+CalculatePoints.swift
//  Snippet
//
//  Created by Seb Vidal on 18/06/2022.
//

import Cocoa

public extension CAGradientLayer {
    func calculatePoints(for angle: CGFloat, type: CAGradientLayerType) {
        var ang = (-angle - 90).truncatingRemainder(dividingBy: 360)
        
        if ang < 0 { ang = 360 + ang }
        
        let n: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b
            
        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b
            
        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
            startPoint = a
            endPoint = b
            
        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b
            
        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b
            
        }
        
        if type != .axial {
            startPoint = CGPoint(x: 0.5, y: 0.5)
        }
        
        print(startPoint, endPoint)
    }
    
    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }
    
    
    // Overloads
    
    /// Sets the start and end points on a gradient layer for a given angle.
    func calculatePoints(for angle: Int, type: CAGradientLayerType) {
        calculatePoints(for: CGFloat(angle), type: type)
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    func calculatePoints(for angle: Float, type: CAGradientLayerType) {
        calculatePoints(for: CGFloat(angle), type: type)
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    func calculatePoints(for angle: Double, type: CAGradientLayerType) {
        calculatePoints(for: CGFloat(angle), type: type)
    }
    
}
