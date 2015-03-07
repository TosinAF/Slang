//
//  NavigationBar.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - NavigationBar Class

class NavigationBar: UIView {
    
    var message: String = "" {
        willSet(msg) { textLabel.text = msg }
    }
    
    var percentageOffset: CGFloat = 0.0 {
        willSet(pcg) {
            var newAlpha = pcg * 100
            logoImageView.alpha = CGFloat(pcg)
            logoImageView.center = center
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.adjustTextLabel()
            })
        }
    }
    
    // MARK: Views
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "SlangLogo")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, 54, 26)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), 15))
        label.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    // MARK: Initalizers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(textLabel)
        
        logoImageView.center = center
        textLabel.center = center
        
        adjustTextLabel()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    override func updateConstraints() {
        super.updateConstraints()
        
        constrain(logoImageView) { imageView in
            imageView.centerX == imageView.superview!.centerX
            imageView.centerY == imageView.superview!.centerY
        }
        
        constrain(textLabel) { view in
            view.centerX == view.superview!.centerX
            view.bottom == view.superview!.bottom - 15
        }
    }
    
    // MARK: Utility Methods
    
    func resetToDefaultState() {
        logoImageView.alpha = 1.0
        logoImageView.center = center
        self.adjustTextLabel()
    }
    
    func adjustTextLabel() {
        let yOrigin = CGRectGetHeight(self.frame) - 30
        var frame = textLabel.frame
        frame.origin.y = yOrigin
        textLabel.frame = frame
    }
}
