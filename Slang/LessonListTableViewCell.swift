//
//  LessonTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

class LessonListTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.PrimaryBrandColor()
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.PrimaryBrandColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    lazy var hexagonView: HexagonView = {
        let hexagonView = HexagonView()
        hexagonView.backgroundColor = UIColor.whiteColor()
        hexagonView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return hexagonView
    }()
    
    var title: String = "" {
        willSet(title) {
            titleLabel.text = title
        }
    }
    
    var desc: String = "" {
        willSet(desc) {
            descLabel.text = desc
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        
        contentView.addSubview(hexagonView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        
        let views = [
            "hexagon": hexagonView,
            "title": titleLabel,
            "desc": descLabel
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-12-[title]-5-[desc]-12-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-12-[hexagon]", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[hexagon]-12-[title]-25-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[hexagon]-12-[desc]-25-|", options: nil, metrics: nil, views: views))
        
        constrain(hexagonView) { hexagonView in
            hexagonView.centerY == hexagonView.superview!.centerY; return
        }
        
        super.updateConstraints()
    }

}
