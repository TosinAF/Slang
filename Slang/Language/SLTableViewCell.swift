//
//  SLBaseTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

// This is an abstract class
// An Instance of this class should never be created
// Unfortunately Swift dosen't support abstract classes

import UIKit
import pop

// MARK: - SLTableViewCell Delegate

protocol SLTableViewCellDelegate: class {
    func tableViewCell(tableViewCellAtIndex index: Int, didUpdateWithBlock block: Block)
}

// MARK: - SLTableViewCell Class

class SLTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var didUpdateConstraints = false
    weak var delegate: SLTableViewCellDelegate?
    
    var state: BlockState = .New {
        willSet {
            configureForState(newValue)
        }
    }
    
    var type: BlockType = .Blank {
        willSet(newType) {
            typeLabel.text = newType.title
            containerView.backgroundColor = newType.color
        }
    }
    
    var lineNumber: String = "0" {
        willSet(num) {
            numberLabel.text = num
        }
    }
    
    // MARK: - Views
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.grayColor()
        return view
    }()

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont(name: "Avenir", size: 10)
        return label
    }()

    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 10)
        label.textColor = UIColor.whiteColor()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    // MARK: - Initalizers

    override init() {
        fatalError("This is an abstract class & as such an instance of this class should never be created")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .None

        contentView.addSubview(containerView)
        contentView.addSubview(numberLabel)
        containerView.addSubview(typeLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            let views = [
                "numberLabel": numberLabel,
                "typeLabel": typeLabel,
                "container": containerView
            ]

            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-25-[numberLabel]-10-[container]-30-|", options: nil, metrics: nil, views: views))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[container]-10-|", options: nil, metrics: nil, views: views))
            contentView.addConstraint(NSLayoutConstraint(item: numberLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-6-[typeLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[typeLabel]", options: nil, metrics: nil, views: views))

            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Configuration Mehtods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        state = .New
    }
    
    func configureForState(state: BlockState) {
        
    }
    
    func configureWithBlock(block: Block) {
        
        (self as SLTableViewCell).state = block.state
        
        switch block {
            
        case .Variable(let name, let value):
            let cell = self as SLVariableTableViewCell
            cell.name = name
            cell.value = value
            
        case .Repeat(let count):
            let cell = self as SLRepeatTableViewCell
            cell.count = count
            
        case .If(let s1, let cond, let s2):
            let cell = self as SLIfTableViewCell
            cell.s1 = s1
            cell.cond = cond
            cell.s2 = s2
            
        case .Print(let statement):
            let cell = self as SLPrintTableViewCell
            cell.statement = statement
            
        default:
            return
        }
    }
    
    // MARK: - Utility Functions

    func createTextfield(#placeholder: String, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "Avenir-Light", size: 14)
        textField.textAlignment = .Center
        textField.tag = tag
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textField
    }

    func createInfoLabel(#text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.alpha = 0.0
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 8)
        return label
    }

    func createSeperatorLabel() -> UILabel {
        let label = UILabel()
        label.text = ":"
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        return label
    }

    func popConstraintAnimation(value: Int) -> POPSpringAnimation {
        let verticalConstraintAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        verticalConstraintAnim.springBounciness = 2
        verticalConstraintAnim.springSpeed = 5
        verticalConstraintAnim.toValue = value
        return verticalConstraintAnim
    }
}


