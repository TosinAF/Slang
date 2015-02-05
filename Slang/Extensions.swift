//
//  Extensions.swift
//  Slang
//
//  Created by Tosin Afolabi on 03/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

extension UITextField {
    func trimWhitespace() {
        self.text = self.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
