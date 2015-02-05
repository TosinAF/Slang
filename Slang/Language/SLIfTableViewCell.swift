//
//  SLIFTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

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

    lazy var statementTwoTextField: UITextField = {
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
        containerView.addSubview(statementTwoTextField)
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
                "statementTwo": statementTwoTextField,
                "statementTwoInfoLabel": statementTwoInfoLabel,
                "conditionOperatorTextField": conditionOperatorTextField,
                "conditionOperatorInfoLabel": conditionOperatorInfoLabel,
                "seperatorLabelOne": seperatorLabelOne,
                "seperatorLabelTwo": seperatorLabelTwo
            ]

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[statementOne(>=30)]-10-[seperatorLabelOne]-10-[conditionOperatorTextField]-10-[seperatorLabelTwo]-10-[statementTwo(>=30)]", options: .AlignAllCenterY, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementOne]-1-[statementOneInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementTwo]-1-[statementTwoInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[conditionOperatorTextField]-1-[conditionOperatorInfoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[conditionOperatorInfoLabel]", options: nil, metrics: nil, views: views))

            constrain(conditionOperatorTextField) { condTextField in
                condTextField.centerX == condTextField.superview!.centerX
                self.textFieldVerticalContraint = (condTextField.centerY == condTextField.superview!.centerY)
            }

            constrain(statementOneInfoLabel, statementOneTextField) { info, textField in
                info.centerX == textField.centerX; return
            }

            constrain(statementTwoInfoLabel, statementTwoTextField) { info, textField in
                info.centerX == textField.centerX; return
            }

            constrain(conditionOperatorInfoLabel, conditionOperatorTextField) { info, textField in
                info.centerX == textField.centerX; return
            }
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
