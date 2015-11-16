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
        self.text = self.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension JSContext {
    
    // https://github.com/dankogai/swift-jsdemo/blob/master/js/main.swift
    
    func fetch(key: String) -> JSValue {
        return getJSVinJSC(self, key)
    }
    
    func store(key: String, _ val: ID) {
        setJSVinJSC(self, key, val)
    }

    func setb0(key: String, _ blk: () -> ID) {
        setB0JSVinJSC(self, key, blk)
    }
    
    func setb1(key: String, _ blk: (ID) -> ID) {
        setB1JSVinJSC(self, key, blk)
    }
    
    func setb2(key: String, _ blk: (ID,ID) -> ID) {
        setB2JSVinJSC(self, key, blk)
    }
    
    // Added in for sub functions like console.log
    func store(key: String, sKey: String, _ blk: (ID) -> ID) {
        setB3JSVinJSC(self, key, sKey, blk)
    }
}
