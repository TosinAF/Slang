//
//  SlangViewModel.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/7/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import JavaScriptCore

class SlangViewModel {
    
    // MARK: - Properties
    
    let blockCount = 6
    var log = ""
    
    lazy var blocks: [Block] = {
        var blocks = [Block]()
        for _ in 0...self.blockCount {
            blocks.append(.Blank)
        }
        return blocks
    }()
    
    lazy var context: JSContext = {
        let context = JSContext(virtualMachine: JSVirtualMachine())
        context.evaluateScript("var console = {};")
        context.store("console", sKey: "log") { (msg:ID)->ID in
            
            self.log = ""
            if msg == nil { return nil }
            
            if let m = msg.toString?() {
                self.log += "\(m)\n"
            } else { 
                self.log += "\(msg)\n"
            }
            
            return nil
        }
        return context
    }()
    
    // MARK: - Public Methods
    
    func block(atIndex index: Int) -> Block {
        return blocks[index]
    }
    
    func updateBlock(atIndex index: Int, withBlock block: Block) {
        blocks[index] = block
    }
    
    func execute() -> String {
        let code = generateCode()
        //println(code)
        executeCode(code)
        return log
    }
    
    // MARK: - Private Methods
    
    private func generateCode() -> String {
        
        var code = ""
        for block in blocks {
            
            switch block {
                
            case .Variable(let name, let value):
                code += "var \(name) = \(value);\n"
                
            case .Repeat(let count):
                code += "for (var i = 0; i < \(count); i++) {\n"
                
            case .If(let s1, let cond, let s2):
                code += "if ( \(s1) \(cond) \(s2) ) {\n"
                
            case .Else:
                code += "} else {\n"
                
            case .Print(let statement):
                code += "console.log(\(statement));\n"
                
            case .End:
                code += "}\n"
                
            case .Blank:
                code += ""
            }
        }
        
        return code
    }
    
    private func executeCode(code: String) {
        context.evaluateScript(code)
    }
}
