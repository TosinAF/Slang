//
//  HexagonShape.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

class HexagonView: UIView {

    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let width = rect.width
        let height = rect.height

        CGContextSaveGState(ctx)
        CGContextMoveToPoint(ctx, 27*(width/54), 4*(height/59))
        CGContextAddCurveToPoint(ctx, 27*(width/54), 4*(height/59), 48.65*(width/54), 16.5*(height/59), 48.65*(width/54), 16.5*(height/59))
        CGContextAddCurveToPoint(ctx, 48.65*(width/54), 16.5*(height/59), 48.65*(width/54), 41.5*(height/59), 48.65*(width/54), 41.49999999999999*(height/59))
        CGContextAddCurveToPoint(ctx, 48.65*(width/54), 41.5*(height/59), 27*(width/54), 54*(height/59), 27*(width/54), 54*(height/59))
        CGContextAddCurveToPoint(ctx, 27*(width/54), 54*(height/59), 5.35*(width/54), 41.5*(height/59), 5.35*(width/54), 41.500000000000014*(height/59))
        CGContextAddCurveToPoint(ctx, 5.35*(width/54), 41.5*(height/59), 5.35*(width/54), 16.5*(height/59), 5.35*(width/54), 16.500000000000014*(height/59))
        CGContextAddCurveToPoint(ctx, 5.35*(width/54), 16.5*(height/59), 27*(width/54), 4*(height/59), 27*(width/54), 4*(height/59))
        CGContextSetStrokeColorWithColor(ctx, UIColor.SecondaryBrandColor().CGColor)
        CGContextSetLineWidth(ctx, 2*min(width/54, height/59))
        CGContextDrawPath(ctx, kCGPathStroke)
        CGContextRestoreGState(ctx)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(27, 30)
    }
}
