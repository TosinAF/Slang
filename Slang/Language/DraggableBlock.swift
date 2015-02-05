//
//  DraggableBlock.swift
//  Slang
//
//  Created by Tosin Afolabi on 05/02/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

class DraggableBlock: UIView {

    // MARK: - Properties

    let type: BlockType
    var didUpdateConstraints = false

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.type.title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    // MARK: - Initalizers

    init(type: BlockType) {
        self.type = type
        super.init(frame: CGRectZero)
        backgroundColor = type.color
        addSubview(titleLabel)
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

            didUpdateConstraints = true
        }

        super.updateConstraints()
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(95, 35)
    }
}
