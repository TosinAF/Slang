//
//  SLPrint.swift
//  Slang
//
//  Created by Tosin Afolabi on 11/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SLPrintTableViewCell Class

class SLPrintTableViewCell: SLTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()
    
    var statement: String = "" {
        willSet {
            printStatementTextField.text = newValue
        }
    }

    lazy var printStatementTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "text", tag: 0)
        textField.delegate = self
        return textField
    }()

    lazy var infoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Statement To Print")
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .Print
        containerView.addSubview(printStatementTextField)
        containerView.addSubview(infoLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            let views = [
                "textField": printStatementTextField,
                "infoLabel": infoLabel
            ]

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[textField]-1-[infoLabel]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[textField(>=100)]", options: [], metrics: nil, views: views))

            constrain(printStatementTextField, infoLabel) { view, view2 in
                view.centerX == view.superview!.centerX
                view2.centerX == view2.superview!.centerX
                self.textFieldVerticalContraint = (view.centerY == view.superview!.centerY)
            }
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Config Methods
    
    override func prepareForReuse() {
        state = .New
    }
    
    override func configureForState(state: BlockState) {
        let alpha: CGFloat = state == .New ? 0.0 : 1.0
        let constant: CGFloat = state == .New ? 0.0 : -5.0
        
        infoLabel.alpha = alpha
        textFieldVerticalContraint.constant = constant
        
        if state == .New {
            statement = ""
        }
    }
}

extension SLPrintTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        let constraintAnim = popConstraintAnimation(-5)
        textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")
        infoLabel.alpha = alpha
    }

    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.trimWhitespace()
        
        let index = max(0, Int(lineNumber)! - 1)
        let block = Block.Print(statement: printStatementTextField.text!)
        delegate?.tableViewCell(tableViewCellAtIndex: index, didUpdateWithBlock: block)
    }
}
