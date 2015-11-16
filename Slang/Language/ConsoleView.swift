//
//  ConsoleView.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import AHKBendableView
import Cartography

class ConsoleView: BendableView {
    
    var dismissButtonAction: (() -> Void)?
    
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
        textView.font = UIFont(name: "Inconsolata", size: 45.0)
        textView.backgroundColor = UIColor.PrimaryBrandColor()
        textView.textColor = UIColor.ConsoleTextColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("\u{274C}", forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Entypo", size: 60.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "onDismissButtonTap", forControlEvents: .TouchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        addSubview(dismissButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        constrain(textView) { textView in
            textView.top == textView.superview!.top
            textView.width == textView.superview!.width
            textView.height == textView.superview!.height
        }
        
        constrain(dismissButton) { button in
            button.height == 30
            button.top == button.superview!.top + 8
            button.right == button.superview!.right - 8
        }
    }
    
    // MARK: - Actions
    
    func onDismissButtonTap() {
        dismissButtonAction?()
    }
}
