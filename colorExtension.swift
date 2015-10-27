//
//  colorExtension.swift
//
//  Copyright (c) 2015, Jan Nejtek
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import UIKit

extension UIColor {
   
    func isDarkColor(threshold: Int = 50) -> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let l: CGFloat = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        
        if (Int(l * 100) < threshold) {
            return true
        }
        else {
            return false
        }
    }
    
    func opaqueColor() -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func isDistinct(compareColor: UIColor, threshold: CGFloat = 0.3) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        compareColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        if fabs(r1-r2) > threshold || fabs(g1-g2) > threshold || fabs(b1-b2) > threshold || fabs(a1-a2) > threshold {
            // rule out multiple grays
            if Int(fabs(r1 - g1) * 100) < 30 && Int(fabs(r1 - b1) * 100) < 30 {
                if Int(fabs(r2 - g2) * 100) < 30 && Int(fabs(r2-b2) * 100) < 30 {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func colorWithSaturation(saturation: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        
        return UIColor(hue: h, saturation: saturation, brightness: b, alpha: a)
    }
    
    func isBlackOrWhite() -> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if Int(r * 100) > 91 && Int(g * 100) > 91 && Int(b * 100) > 91 {
            return true
        }
        if Int(r * 100) < 9 && Int(g * 100) < 9 && Int(b * 100) < 9 {
            return true
        }
        return false
    }
    
    func isContrastingColor(color: UIColor) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let l1: CGFloat = 0.2126 * r1 + 0.7152 * g1 + 0.0722 * b1;
        let l2: CGFloat = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2;
        
        var contrast: CGFloat = 0.0
        
        if l1 > l2 {
            contrast = (l1 + 0.05) / (l2 + 0.05)
        }
        else {
            contrast = (l2 + 0.05) / (l1 + 0.05)
        }
        
        if Int(contrast * 10) > 18 {
            return true
        }
        else {
            return false
        }
    }
    
    func getBrightness() -> Float {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let l: CGFloat = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        return Float(l)
    }
    
    func getBrightVariant(maxMultiplier: CGFloat = 10.0) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb_comp = [r, g, b]
        
        let multiplier: CGFloat = 1.0 / rgb_comp.maxElement()!
        
        if multiplier < maxMultiplier {
            return UIColor(red: r * multiplier, green: g * multiplier, blue: b * multiplier, alpha: a)
        }
        else {
            return UIColor(red: r * maxMultiplier, green: g * maxMultiplier, blue: b * maxMultiplier, alpha: a)
        }
    }
}
