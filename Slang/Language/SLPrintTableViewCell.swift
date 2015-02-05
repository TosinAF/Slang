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

class SLPrintTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()

    lazy var printStatementTextField: UITextField = {
        let textField = UITextField()
        textField.text = "text"
        textField.delegate = self
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 16)
        textField.textAlignment = .Center
        textField.tag = 0
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }()

    lazy var infoLabel: UILabel = {
        let label = self.createInfoLabel(text: "String To Print")
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLPrint
        containerView.backgroundColor = UIColor(red:0.106, green:0.639, blue:0.612, alpha: 1)
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

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[textField]-1-[infoLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[textField(>=100)]", options: nil, metrics: nil, views: views))

            constrain(printStatementTextField, infoLabel) { view, view2 in
                view.centerX == view.superview!.centerX
                view2.centerX == view2.superview!.centerX
                self.textFieldVerticalContraint = (view.centerY == view.superview!.centerY)
            }
        }
        
        super.updateConstraints()
    }
}

extension SLPrintTableViewCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {

        let constraintAnim = popConstraintAnimation(-5)
        textFieldVerticalContraint.pop_addAnimation(constraintAnim, forKey: "constant")

        infoLabel.alpha = 1.0
        textField.text = ""
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.trimWhitespace()
    }
}
