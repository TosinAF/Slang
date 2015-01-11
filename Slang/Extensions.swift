//
//  Extensions.swift
//  Slang
//
//  Created by Tosin Afolabi on 03/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

extension UIColor {

    class func SLVariableColor() -> UIColor {
        return UIColor(red: 0.290, green: 0.565, blue:0.886, alpha:1.0)
    }

}

extension UITextField {
    func trimWhitespace() {
        self.text = self.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
