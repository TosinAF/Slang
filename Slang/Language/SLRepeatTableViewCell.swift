//
//  SLRepeatTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import pop
import Cartography

// MARK: - SLRepeatTableViewCell Class

class SLRepeatTableViewCell: SLTableViewCell {

    // MARK: - Properties

    var textFieldVerticalContraint = NSLayoutConstraint()
    
    var count: String = "" {
        willSet {
            repeatCountTextField.text = newValue
        }
    }

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

        type = .Repeat
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

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[textField]-1-[infoLabel]", options: [], metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[textField(>=100)]", options: [], metrics: nil, views: views))

            constrain(repeatCountTextField, infoLabel) { view, view2 in
                view.centerX == view.superview!.centerX
                view2.centerX == view2.superview!.centerX
                self.textFieldVerticalContraint = (view.centerY == view.superview!.centerY)
            }
        }

        super.updateConstraints()
    }
    
    // MARK: - Config Methods
    
    override func configureForState(state: BlockState) {
        let alpha: CGFloat = state == .New ? 0.0 : 1.0
        let constant: CGFloat = state == .New ? 0.0 : -5.0
        
        infoLabel.alpha = alpha
        textFieldVerticalContraint.constant = constant
        
        if state == .New {
            count = ""
        }
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
        
        let index = max(0, Int(lineNumber)! - 1)
        let block = Block.Repeat(count: repeatCountTextField.text!)
        delegate?.tableViewCell(tableViewCellAtIndex: index, didUpdateWithBlock: block)
    }
}

