//
//  DraggableBlock.swift
//  Slang
//
//  Created by Tosin Afolabi on 05/21/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

protocol DraggableBlockDelegate: class {
    func draggableBlock(panGestureDidFinishWithDraggableBlock draggableBlock: DraggableBlock)
}

class DraggableBlock: UIView {

    // MARK: - Properties

    let type: BlockType
    var lastLocation: CGPoint = CGPointMake(0, 0)
    var isBeingDragged: Bool = false
    weak var delegate: DraggableBlockDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.type.title
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initalizers

    init(type: BlockType) {
        self.type = type
        super.init(frame: CGRectZero)

        backgroundColor = type.color
        addSubview(titleLabel)
        
        if type == .Blank { titleLabel.textColor = UIColor.blackColor() }

        let panRecognizer = UIPanGestureRecognizer(target: self, action: "detectPan:")
        self.gestureRecognizers = [panRecognizer]
    }
   
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    override func updateConstraints() {

        constrain(titleLabel) { titleLabel in
            titleLabel.centerX == titleLabel.superview!.centerX
            titleLabel.centerY == titleLabel.superview!.centerY
        }

        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        if (isBeingDragged) {
            drawShadow()
        } else {
            layer.shadowOpacity = 0.0
        }
    }

    // MARK: - Pan Gesture Recognizer

    func detectPan(sender: UIPanGestureRecognizer) {
        if sender.state == .Ended {
            delegate?.draggableBlock(panGestureDidFinishWithDraggableBlock: sender.view as! DraggableBlock)
            isBeingDragged = false
            return
        }

        let translation  = sender.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
        isBeingDragged = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }
    
    // MARK: - Utility Functions
    
    func drawShadow() {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 0.5)
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.CGPath
    }
}
