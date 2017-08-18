//
//  UIColor+Extension.swift
//  flower
//
//  Created by liangqi on 16/1/7.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hexColor(_ color: String, alpha: Float) -> UIColor{
        
        let formatColor = color.trimmingCharacters(in: .whitespaces).uppercased();
        if !formatColor.hasPrefix("#") {
            return UIColor.clear;
        }
        
        let colorVal:String = formatColor.substring(from: formatColor.characters.index(formatColor.startIndex, offsetBy: 1));
        
        if colorVal.lengthOfBytes(using: .utf8) % 3 != 0 {
            return UIColor.clear;
        }
        
        var rColor,gColor,bColor: String?;
        
        if colorVal.lengthOfBytes(using: .utf8) == 3 {
            let rIndex = colorVal.characters.index(colorVal.startIndex, offsetBy: 0);
            let gIndex = colorVal.characters.index(colorVal.startIndex, offsetBy: 1);
            let bIndex = colorVal.characters.index(colorVal.startIndex, offsetBy: 2);
            
            rColor = String(colorVal[rIndex]) + String(colorVal[rIndex]);
            gColor = String(colorVal[gIndex]) + String(colorVal[gIndex]);
            bColor = String(colorVal[bIndex]) + String(colorVal[bIndex]);
        }
        
        if colorVal.lengthOfBytes(using: .utf8) == 6 {
            rColor = colorVal.substring(0, length: 2);
            gColor = colorVal.substring(2, length: 2);
            bColor = colorVal.substring(4, length: 2);
        }
        

        return UIColor.init(colorLiteralRed: Float(Int.init(rColor!, radix: 16)!)/255.0, green: Float(Int.init(gColor!, radix: 16)!)/255.0, blue: Float(Int.init(bColor!, radix: 16)!)/255.0, alpha: alpha);
    }
    
    static func hexColor(_ color: String) -> UIColor?{
        let color = hexColor(color, alpha: 1.0);
        
        return color;
    }
    
    
}
