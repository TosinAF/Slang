//
//  Extensions.swift
//  Slang
//
//  Created by Tosin Afolabi on 03/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import JavaScriptCore

extension UITextField {
    func trimWhitespace() {
        self.text = self.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension JSContext {
    
    // https://github.com/dankogai/swift-jsdemo/blob/master/js/main.swift
    
    func fetch(key:NSString)->JSValue {
        return getJSVinJSC(self, key)
    }
    func store(key:NSString, _ val:ID) {
        setJSVinJSC(self, key, val)
    }
    func store(key:NSString, _ blk:()->ID) {
        setB0JSVinJSC(self, key, blk)
    }
    func store(key:NSString, _ blk:(ID)->ID) {
        setB1JSVinJSC(self, key, blk)
    }
    func store(key:NSString, _ blk:(ID,ID)->ID) {
        setB2JSVinJSC(self, key, blk)
    }
    func store(key:NSString, sKey: NSString, _ blk:(ID)->ID) {
        setB3JSVinJSC(self, key, sKey, blk)
    }
}
