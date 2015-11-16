//
//  SLVariableTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 03/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SLVariableTableViewCell Class

class SLVariableTableViewCell: SLTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()
    
    var name: String = "" {
        willSet {
            variableNameTextField.text = newValue
        }
    }
    
    var value: String = "" {
        willSet {
            variableValueTextField.text = newValue
        }
    }
    
    lazy var variableNameTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "Name", tag: 0)
        textField.delegate = self
        return textField
    }()

    lazy var nameInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Name")
        return label
    }()

    lazy var variableValueTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "Value", tag: 1)
        textField.delegate = self
        return textField
    }()

    lazy var valueInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Value")
        return label
    }()

    lazy var seperatorLabel: UILabel = {
        return self.createSeperatorLabel()
    }()
    
    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .Variable

        containerView.addSubview(variableNameTextField)
        containerView.addSubview(variableValueTextField)
        containerView.addSubview(seperatorLabel)
        containerView.addSubview(nameInfoLabel)
        containerView.addSubview(valueInfoLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            let views = [
                "name": variableNameTextField,
                "seperator": seperatorLabel,
                "value": variableValueTextField,
                "nameIndicator": nameInfoLabel,
                "valueIndicator": valueInfoLabel
            ]

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[name(>=30)]-10-[seperator]-10-[value(>=30)]", options: .AlignAllCenterY, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[name]-1-[nameIndicator]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[value]-1-[valueIndicator]", options: [], metrics: nil, views: views))

            constrain(nameInfoLabel, variableNameTextField) { nameInfoLabel, variableNameTextField in
                nameInfoLabel.centerX == variableNameTextField.centerX; return
            }

            constrain(valueInfoLabel, variableValueTextField) { valueInfoLabel, variableValueTextField in
                valueInfoLabel.centerX == variableValueTextField.centerX; return
            }

            constrain(seperatorLabel) { seperatorLabel in
                seperatorLabel.centerX == seperatorLabel.superview!.centerX; return
                self.textFieldVerticalContraint = (seperatorLabel.centerY == seperatorLabel.superview!.centerY)
            }
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Config Methods
    
    override func configureForState(state: BlockState) {
        let alpha: CGFloat = state == .New ? 0.0 : 1.0
        let constant: CGFloat = state == .New ? 0.0 : -5.0
        
        nameInfoLabel.alpha = alpha
        valueInfoLabel.alpha = alpha
        textFieldVerticalContraint.constant = constant
        
        if state == .New {
            name = ""; value = ""
        }
    }
}

// MARK: - UITextFieldDelegate

extension SLVariableTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        let constraintAnim = popConstraintAnimation(-5)
        textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")
        nameInfoLabel.alpha = 1.0
        valueInfoLabel.alpha = 1.0
    }

    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.trimWhitespace()
        
        let index = max(0, Int(lineNumber)! - 1)
        let block = Block.Variable(name: variableNameTextField.text!, value: variableValueTextField.text!)
        delegate?.tableViewCell(tableViewCellAtIndex: index, didUpdateWithBlock: block)
    }
}
