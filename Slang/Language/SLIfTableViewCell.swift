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

class SLIfTableViewCell: SLTableViewCell {

    // MARK: - Properties
    
    var textFieldVerticalContraint = NSLayoutConstraint()
    
    var s1: String = "" {
        willSet {
            statementOneTextField.text = newValue
        }
    }
    
    var cond: String = "" {
        willSet {
            conditionOperatorTextField.text = newValue
        }
    }
    
    var s2: String = "" {
        willSet {
            statementTwoTextField.text = newValue
        }
    }
    
    // MARK: - Views

    lazy var statementOneTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "S1", tag: 0)
        textField.delegate = self
        return textField
    }()

    lazy var statementOneInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Statement 1")
        return label
    }()

    lazy var statementTwoTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "S2", tag: 1)
        textField.delegate = self
        return textField
    }()

    lazy var statementTwoInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Statement 2")
        return label
    }()

    lazy var conditionOperatorTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "==", tag: 2)
        textField.delegate = self
        return textField
    }()

    lazy var conditionOperatorInfoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Operator")
        return label
    }()
    
    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .If
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
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementOne]-1-[statementOneInfoLabel]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[statementTwo]-1-[statementTwoInfoLabel]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[conditionOperatorTextField]-1-[conditionOperatorInfoLabel]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[conditionOperatorInfoLabel]", options: [], metrics: nil, views: views))

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
    
    // MARK: - Config Methods
    
    override func configureForState(state: BlockState) {
        let alpha: CGFloat = state == .New ? 0.0 : 1.0
        let constant: CGFloat = state == .New ? 0.0 : -5.0
        
        statementOneInfoLabel.alpha = alpha
        statementTwoInfoLabel.alpha = alpha
        conditionOperatorInfoLabel.alpha = alpha
        textFieldVerticalContraint.constant = constant
        
        if state == .New {
            s1 = ""; cond = ""; s2 = ""
        }
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
    }

    func textFieldDidEndEditing(textField: UITextField) {
        
        textField.trimWhitespace()
        
        let index = max(0, Int(lineNumber)! - 1)
        let block = Block.If(s1: statementOneTextField.text!, condOp: conditionOperatorTextField.text!, s2: statementTwoTextField.text!)
        delegate?.tableViewCell(tableViewCellAtIndex: index, didUpdateWithBlock: block)
    }
}
