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

// MARK: - SLBaseTableViewCell Class

class SLBaseTableViewCell: UITableViewCell {

    // MARK: - Properties

    let horizontalPadding = 30

    var type: BlockType = .SLBlank {
        willSet(newType) {
            typeLabel.text = newType.title
        }
    }
    var didUpdateConstraints = false

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

    var lineNumber: String = "0" {
        willSet(num) {
            numberLabel.text = num
        }
    }

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

            let metrics = [
                "hPadding": horizontalPadding
            ]

            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-(hPadding)-[numberLabel]-10-[container]-(hPadding)-|", options: nil, metrics: metrics, views: views))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[container]-10-|", options: nil, metrics: nil, views: views))
            contentView.addConstraint(NSLayoutConstraint(item: numberLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1, constant: 0))

            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-6-[typeLabel]", options: nil, metrics: nil, views: views))
            containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[typeLabel]", options: nil, metrics: nil, views: views))

            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }

    // MARK: - Utility Functions

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


