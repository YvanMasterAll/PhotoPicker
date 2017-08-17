//
//  String+Extension.swift
//  flower
//
//  Created by liangqi on 16/1/7.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var length: Int {
        return self.characters.count;
    }
    
    func trim()->String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
    }
    
    
    /// 字符串正则表达式替换
    ///
    /// - Parameter pattern: regx pattern
    /// - Returns: the result string
    func regxReplace(pattern:String, to: String) -> String? {
        do {
            let regx = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            return regx.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSRange.init(location: 0, length: self.characters.count), withTemplate: to)
        } catch {
            return nil
        }
    }
    
    
    /// the first match string
    ///
    /// - Parameter pattern: regex pattern
    /// - Returns: matched string or nil
    func firstMatched(pattern: String) -> String? {
        do {
            let mathes = try NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
            let first = mathes.rangeOfFirstMatch(in: self, options: .withTransparentBounds, range: NSRange.init(location: 0, length: self.characters.count))
            let tmp = self as NSString
            return tmp.substring(with: first)
        } catch {
        }
        return nil
    }
    
    
    /**
     * 截取子字符串
     */
    func substring(_ start: Int, length: Int)->String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: start)
        let endIndex = self.characters.index(self.startIndex, offsetBy: start+length);
        return self[(startIndex ..< endIndex)];
    }
    
    /**
     获取自动折行文字size大小
     
     - parameter fontSize: 字体大小
     */
    func getSingleLineSize(_ fontSize: CGFloat) -> CGSize{
        let ocString: NSString = self as NSString;
        return ocString.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)]);
    }
    
    /**
     正则匹配
    
     - parameter pattern: 正则表达式
     */
    func isMatched(pattern: String) -> Bool {
        do {
            let mathes = try NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
            if mathes.numberOfMatches(in: self, options: .reportProgress, range: NSRange.init(location: 0, length: self.characters.count)) > 0 {
                return  true
            }
        } catch {
            
        }
        return false
    }
    
    
}
