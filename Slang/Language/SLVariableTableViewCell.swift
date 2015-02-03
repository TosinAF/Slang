//
//  SLVariableTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 03/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

// MARK: - SLVariableTableViewCell Class

class SLVariableTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()

    lazy var variableNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "name"
        textField.delegate = self
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 14)
        textField.textAlignment = .Center
        textField.tag = 0
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }()

    lazy var nameInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "name")
        return label
    }()

    lazy var variableValueTextField: UITextField = {
        let textField = UITextField()
        textField.text = "value"
        textField.delegate = self
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 14)
        textField.textAlignment = .Center;
        textField.tag = 1
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }()

    lazy var valueInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "value")
        return label
    }()

    lazy var seperatorLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLVariable
        containerView.backgroundColor = UIColor(red:0.267, green:0.424, blue:0.702, alpha: 1)

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

            containerView.addConstraint(NSLayoutConstraint(item: nameInfoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: variableNameTextField, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: valueInfoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: variableValueTextField, attribute: .CenterX, multiplier: 1, constant: 0))

            textFieldVerticalContraint = NSLayoutConstraint(item: seperatorLabel, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1, constant: 0)
            containerView.addConstraint(textFieldVerticalContraint)

            containerView.addConstraint(NSLayoutConstraint(item: seperatorLabel, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
        }
        
        super.updateConstraints()
    }
}

// MARK: - UITextFieldDelegate

extension SLVariableTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {

        //let constraintAnim = popConstraintAnimation(-5)
        //textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")

        nameInfoLabel.alpha = 1.0
        valueInfoLabel.alpha = 1.0

        textField.text = ""
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.trimWhitespace()
    }
}
