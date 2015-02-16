//
//  ConsoleView.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/13/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import AHKBendableView
import Cartography

class ConsoleView: BendableView {
    
    var log: String = "" {
        willSet {
            textView.text = newValue
        }
    }
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.editable = false
        textView.selectable = false
        textView.scrollEnabled = true
        textView.backgroundColor = UIColor.PrimaryBrandColor()
        textView.textColor = UIColor.ConsoleTextColor()
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        layout(textView) { textView in
            textView.top == textView.superview!.top
            textView.width == textView.superview!.width
            textView.height == textView.superview!.height
        }
    }

}
