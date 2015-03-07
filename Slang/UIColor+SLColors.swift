//
//  UIColor+SLColors.swift
//  Slang
//
//  Created by Tosin Afolabi on 05/02/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func ConsoleTextColor() -> UIColor {
        return UIColor(red:0.118, green:0.510, blue:0.298, alpha: 1)
    }

    class func SLBlankColor() -> UIColor {
        return UIColor.whiteColor()
    }

    class func SLVariableColor() -> UIColor {
        return UIColor(red: 0.290, green: 0.565, blue:0.886, alpha:1.0)
    }

    class func SLEndColor() -> UIColor {
        return UIColor(red:0.200, green:0.431, blue:0.482, alpha: 1.0)
    }

    class func SLPrintColor() -> UIColor {
        return UIColor(red: 0.839, green:0.271, blue:0.255, alpha:1.0)
    }

    class func SLRepeatColor() -> UIColor {
        return UIColor(red:0.012, green:0.651, blue:0.471, alpha: 1.0)
    }

    class func SLIfColor() -> UIColor {
        return UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1.0)
    }

    class func SLElseColor() -> UIColor {
        return UIColor(red:0.141, green:0.490, blue:0.686, alpha: 1.0)
    }
}
