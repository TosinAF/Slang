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

class SLVariableTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()

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

        type = .SLVariable

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
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[name]-1-[nameIndicator]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[value]-1-[valueIndicator]", options: nil, metrics: nil, views: views))

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
    }
}
