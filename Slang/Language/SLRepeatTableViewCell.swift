//
//  SLRepeatTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SLRepeatTableViewCell Class

class SLRepeatTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()

    lazy var repeatCountTextField: UITextField = {
        let textField = self.createTextfield(placeholder: "Count", tag: 0)
        textField.delegate = self
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

            constrain(repeatCountTextField, infoLabel) { view, view2 in
                view.centerX == view.superview!.centerX
                view2.centerX == view2.superview!.centerX
                self.textFieldVerticalContraint = (view.centerY == view.superview!.centerY)
            }
        }

        super.updateConstraints()
    }
}

extension SLRepeatTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        let constraintAnim = popConstraintAnimation(-5)
        textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")
        infoLabel.alpha = 1.0
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.trimWhitespace()
    }
}

