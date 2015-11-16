//
//  SLElseTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 12/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SLElseTableViewCell

class SLElseTableViewCell: SLTableViewCell {

    // MARK: - Properties

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ELSE"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .Else
        typeLabel.alpha = 0.0
        containerView.addSubview(titleLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            constrain(titleLabel) { titleLabel in
                titleLabel.centerX == titleLabel.superview!.centerX
                titleLabel.centerY == titleLabel.superview!.centerY
            }
        }
        
        super.updateConstraints()
    }
}

