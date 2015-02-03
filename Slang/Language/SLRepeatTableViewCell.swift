//
//  SLRepeatTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

// MARK: - SLRepeatTableViewCell Class

class SLRepeatTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var firstEdit = true
    var textFieldVerticalContraint: NSLayoutConstraint?

    lazy var repeatCountTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Repeat Count"
        textField.delegate = self
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 16)
        textField.textAlignment = .Center
        textField.tag = 0
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }()

    lazy var infoLabel: UILabel = {
        let label = self.createInfoLabel(text: "Repeat Count")
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLRepeat
        containerView.backgroundColor = UIColor(red:0.106, green:0.639, blue:0.612, alpha: 1)
        containerView.addSubview(repeatCountTextField)
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
                "textField": repeatCountTextField,
                "infoLabel": infoLabel
            ]

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[textField]-1-[infoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[textField(>=100)]", options: nil, metrics: nil, views: views))
            containerView.addConstraint(NSLayoutConstraint(item: repeatCountTextField, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
            textFieldVerticalContraint = NSLayoutConstraint(item: repeatCountTextField, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1, constant: 0)
            containerView.addConstraint(textFieldVerticalContraint!)
        }

        super.updateConstraints()
    }
}

extension SLRepeatTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {

        if firstEdit {

            let constraintAnim = popConstraintAnimation(-5)
            textFieldVerticalContraint!.pop_addAnimation(constraintAnim, forKey: "constant")

            infoLabel.alpha = 1.0
            repeatCountTextField.text = ""

            firstEdit = false
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.trimWhitespace()
    }
}

