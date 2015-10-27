//
//  imageExtension.swift
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

extension UIImage {
    func colorAtXY(x: Int, y: Int) -> UIColor {
        let provider: CGDataProviderRef = CGImageGetDataProvider(self.CGImage)!
        let pixelData: CFDataRef = CGDataProviderCopyData(provider)!
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let numberOfColorComponents: Int = 4
        let w: Int = Int(self.size.width)
        let pixelInfo: Int = ((w * y) + x) * numberOfColorComponents
        
        let red: UInt8 = data[pixelInfo]
        let green: UInt8 = data[(pixelInfo + 1)]
        let blue: UInt8 = data[pixelInfo + 2]
        let alpha: UInt8 = data[pixelInfo + 3]
        
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: CGFloat(alpha / 255))
    }
    
    func resize(newsize: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: newsize.width, height: newsize.height)
        UIGraphicsBeginImageContextWithOptions(newsize, false, 1.0)
        self.drawInRect(rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func averageColor() -> UIColor {
        let rgba = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let info = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context: CGContextRef = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, info.rawValue)!
        
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage)
        
        let result: UIColor = UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
        
        rgba.destroy()
        rgba.dealloc(4)
        
        return result
    }
}