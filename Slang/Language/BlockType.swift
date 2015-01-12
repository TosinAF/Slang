//
//  BlockType.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import Foundation

enum BlockType: Int {
    //case SLBlank = 0, SLVariable, SLIF, SLElse, SLElseIF, SLRepeat, SLEnd, SLPrint
    case SLBlank = 0, SLVariable, SLEnd, SLPrint

    var identifier: String {
        let identifiers = ["blank", "variable", "end", "print"]
        return identifiers[self.rawValue]
    }

    var title: String {
        let titles = ["BLANK", "VARIABLE", "END", "PRINT"]
        return titles[self.rawValue]
    }

    var tableViewCellClass: AnyClass {
        let classes: [AnyClass] = [SLBlankTableViewCell.self, SLVariableTableViewCell.self, SLEndTableViewCell.self, SLPrintTableViewCell.self]
        return classes[self.rawValue]
    }

    static let allTypes: [BlockType] = [.SLBlank, .SLVariable, SLEnd, SLPrint]
}
