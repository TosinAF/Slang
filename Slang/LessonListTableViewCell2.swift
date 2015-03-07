//
//  LessonTableViewCell.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

class LessonListTableViewCell2: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PrimaryBrandColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()
    
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
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.slGrayColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
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
        
        contentView.addSubview(bannerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(seperatorView)
        
        setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        
        let views = [
            "banner": bannerView,
            "title": titleLabel,
            "desc": descLabel,
            "seperator": seperatorView
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[banner]-20-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[title]-20-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[desc]-20-|", options: nil, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[seperator]-20-|", options: nil, metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[banner(140)]-15-[title]-15-[desc]-25-[seperator(1)]|", options: nil, metrics: nil, views: views))
        
        super.updateConstraints()
    }
    
}
