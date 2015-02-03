//
//  SLIFTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

// MARK: - SLIfTableViewCell Class

class SLIfTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()

    lazy var statementOneTextField: UITextField = {
        let textField = self.createStatementTextfield(text: "S1", tag: 0)
        return textField
    }()

    lazy var statementOneInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Statement 1")
        return label
    }()

    lazy var statmentTwoTextField: UITextField = {
        let textField = self.createStatementTextfield(text: "S2", tag: 1)
        return textField
    }()

    lazy var statementTwoInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Statement 2")
        return label
    }()

    lazy var conditionOperatorTextField: UITextField = {
        let textField = self.createStatementTextfield(text: "==", tag: 2)
        return textField
    }()

    lazy var conditionOperatorInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Operator")
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLIf
        containerView.backgroundColor = UIColor(red:0.106, green:0.639, blue:0.612, alpha: 1)
        containerView.addSubview(statementOneTextField)
        containerView.addSubview(statementOneInfoLabel)
        containerView.addSubview(statmentTwoTextField)
        containerView.addSubview(statementTwoInfoLabel)
        containerView.addSubview(conditionOperatorTextField)
        containerView.addSubview(conditionOperatorInfoLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            let seperatorLabelOne = createSeperatorLabel()
            let seperatorLabelTwo = createSeperatorLabel()

            containerView.addSubview(seperatorLabelOne)
            containerView.addSubview(seperatorLabelTwo)

            let views = [
                "statementOne": statementOneTextField,
                "statementOneInfoLabel": statementOneInfoLabel,
                "statementTwo": statmentTwoTextField,
                "statementTwoInfoLabel": statementTwoInfoLabel,
                "conditionOperatorTextField": conditionOperatorTextField,
                "conditionOperatorInfoLabel": conditionOperatorInfoLabel,
                "seperatorLabelOne": seperatorLabelOne,
                "seperatorLabelTwo": seperatorLabelTwo
            ]

            textFieldVerticalContraint = NSLayoutConstraint(item: conditionOperatorTextField, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1, constant: 0)
            containerView.addConstraint(NSLayoutConstraint(item: conditionOperatorTextField, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(textFieldVerticalContraint)

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[statementOne(>=30)]-10-[seperatorLabelOne]-10-[conditionOperatorTextField]-10-[seperatorLabelTwo]-10-[statementTwo(>=30)]", options: .AlignAllCenterY, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementOne]-1-[statementOneInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementTwo]-1-[statementTwoInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[conditionOperatorTextField]-1-[conditionOperatorInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[conditionOperatorInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraint(NSLayoutConstraint(item: statementOneInfoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: statementOneTextField, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: statementTwoInfoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: statmentTwoTextField, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: conditionOperatorInfoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: conditionOperatorTextField, attribute: .CenterX, multiplier: 1, constant: 0))
        }
        
        super.updateConstraints()
    }

    // MARK: - Utility Functions

    func createStatementTextfield(#text: String, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 14)
        textField.textAlignment = .Center
        textField.tag = tag
        textField.delegate = self
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }

    func createSeperatorLabel() -> UILabel {
        let label = UILabel()
        label.text = ":"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        return label
    }
}

// MARK: - UITextFieldDelegate

extension SLIfTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {

        let constraintAnim = popConstraintAnimation(-5)
        textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")

        statementOneInfoLabel.alpha = 1.0
        statementTwoInfoLabel.alpha = 1.0
        conditionOperatorInfoLabel.alpha = 1.0

        textField.text = ""
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.trimWhitespace()
    }
}
