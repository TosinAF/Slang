//
//  SLElseTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

// MARK: - SLElseTableViewCell

class SLElseTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "ELSE"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLElse
        self.typeLabel.text = ""
        containerView.backgroundColor = UIColor(red:0.404, green:0.255, blue:0.447, alpha: 1)
        containerView.addSubview(infoLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            containerView.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1, constant: 0))
        }
        
        super.updateConstraints()
    }
}

