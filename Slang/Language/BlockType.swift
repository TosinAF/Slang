//
//  BlockType.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import Foundation
import UIKit

enum BlockType: Int {
    case Blank = 0, Variable, Repeat, If, Else, End, Print

    var identifier: String {
        let identifiers = ["blank", "variable", "repeat", "if", "else", "end", "print"]
        return identifiers[self.rawValue]
    }

    var title: String {
        let titles = ["BLANK", "VARIABLE", "REPEAT", "IF Statement", "ELSE", "END", "PRINT"]
        return titles[self.rawValue]
    }

    var tableViewCellClass: AnyClass {
        let classes: [AnyClass] = [
            SLBlankTableViewCell.self,
            SLVariableTableViewCell.self,
            SLRepeatTableViewCell.self,
            SLIfTableViewCell.self,
            SLElseTableViewCell.self,
            SLEndTableViewCell.self,
            SLPrintTableViewCell.self
        ]
        return classes[self.rawValue]
    }

    var color: UIColor {
        let colors = [
            UIColor.SLBlankColor(),
            UIColor.SLVariableColor(),
            UIColor.SLRepeatColor(),
            UIColor.SLIfColor(),
            UIColor.SLElseColor(),
            UIColor.SLEndColor(),
            UIColor.SLPrintColor()
        ]
        return colors[self.rawValue]
    }

    static let allTypes: [BlockType] = [Blank, Variable, Repeat, If, Else, End, Print]
    
    static let editableTypes: [BlockType] = [Variable, Repeat, If, Print]
}


