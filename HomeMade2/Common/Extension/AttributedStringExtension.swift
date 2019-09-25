//
//  StringExtension.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stringToColor(strValue: String , color: UIColor) -> NSAttributedString {

        let range = (self as NSString).range(of: strValue)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    
//    func stringToColor(strValue1: String , color1: UIColor , strValue2: String , color2: UIColor) -> NSMutableAttributedString {
//        print(strValue1)
//        print(strValue2)
//        let range1 = (self as NSString).range(of: strValue1)
//        let attributedString1 = NSMutableAttributedString(string:self)
//        let range2 = (self as NSString).range(of: strValue2)
//        let attributedString2 = NSMutableAttributedString(string:self)
//        attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: color1 , range: range1)
//        attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: color2 , range: range2)
//        let combination = NSMutableAttributedString()
//        combination.append(attributedString1)
//        combination.append(attributedString2)
//        print(combination)
//
//        print(attributedString1)
//        print(attributedString2)
//        return combination
//    }
    
    func trim() -> String
        {
            return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
        }

}

