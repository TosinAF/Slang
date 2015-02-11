//
//  Block.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/7/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

enum BlockState {
    case New, Edited
}

enum Block {
    case Blank
    case Variable(name: String, value: String)
    case Repeat(count: String)
    case If(s1: String, condOp: String, s2: String)
    case Else
    case End
    case Print(statement: String)
    
    var type: BlockType {
        switch self {
        case Blank: return .Blank
        case Variable: return .Variable
        case Repeat: return .Repeat
        case If: return .If
        case Else: return .Else
        case End: return .End
        case Print: return .Print
        }
    }
    
    var state: BlockState {
        switch self {
            
        case Variable(let name, let value):
            return ( name == "" && value == "" ? .New : .Edited )
            
        case Repeat(let count):
            return ( count == "" ? .New : .Edited )
            
        case If(let s1, let cond, let s2):
            return ( s1 == "" && cond == "" && s2 == "" ? .New : .Edited )
            
        case Print(let statement):
            return ( statement == "" ? .New : .Edited )
            
        default:
            return .New
        }
    }
    
    var description: String {
        switch self {
        case Variable(let name, let value):
            return "Variable Block - Name: \(name),  Value: \(value)"
        case Repeat(let count):
            return "Repeat Block - Count: \(count)"
        case If(let s1, let cond, let s2):
            return "If Block - S1: \(s1), Cond: \(cond), S2: \(s2)"
        case Print(let statement):
            return "Print Block - Statement: \(statement)"
        default:
            return "\(self.type.title) Block"
        }
    }
}

extension Block {
    static func createBlock(type: BlockType) -> Block {
        switch type {
        case .Blank:
            return Blank
        case .Variable:
            return Variable(name: "", value: "")
        case .Repeat:
            return Repeat(count: "")
        case .If: return
            If(s1: "", condOp: "", s2: "")
        case .Else:
            return Else
        case .End:
            return End
        case .Print:
            return Print(statement: "")
        }
    }
}
