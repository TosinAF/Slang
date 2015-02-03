//
//  BlockType.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import Foundation

enum BlockType: Int {
    case SLBlank = 0, SLVariable, SLIf, SLElse, SLRepeat, SLEnd, SLPrint

    var identifier: String {
        let identifiers = ["blank", "variable", "if", "else", "repeat", "end", "print"]
        return identifiers[self.rawValue]
    }

    var title: String {
        let titles = ["BLANK", "VARIABLE", "IF Statement", "Else", "REPEAT", "END", "PRINT"]
        return titles[self.rawValue]
    }

    var tableViewCellClass: AnyClass {
        let classes: [AnyClass] = [
            SLBlankTableViewCell.self,
            SLVariableTableViewCell.self,
            SLIfTableViewCell.self,
            SLElseTableViewCell.self,
            SLRepeatTableViewCell.self,
            SLEndTableViewCell.self,
            SLPrintTableViewCell.self
        ]
        return classes[self.rawValue]
    }

    static let allTypes: [BlockType] = [SLBlank, SLVariable, SLIf, SLElse, SLRepeat, SLEnd, SLPrint]
}
