//
//  SLEndTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 11/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SLPrintTableViewCell Class

class SLEndTableViewCell: SLBaseTableViewCell {

    // MARK: - Properties

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "END"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    // MARK: - Initalizers

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        type = .SLEnd
        typeLabel.alpha = 0.0
        containerView.backgroundColor = UIColor(red:0.404, green:0.255, blue:0.447, alpha: 1)
        containerView.addSubview(titleLabel)

        setNeedsUpdateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        if (!didUpdateConstraints) {

            layout(titleLabel) { titleLabel in
                titleLabel.centerX == titleLabel.superview!.centerX
                titleLabel.centerY == titleLabel.superview!.centerY
            }

        }

        super.updateConstraints()
    }
}