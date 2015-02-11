//
//  SlangViewModel.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/7/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

class SlangViewModel {
    
    // MARK: - Properties
    
    let blockCount = 6
    
    lazy var blocks: [Block] = {
        var blocks = [Block]()
        for _ in 0...self.blockCount {
            blocks.append(.Blank)
        }
        return blocks
    }()
    
    // MARK: - Public Methods
    
    func block(index: Int) -> Block {
        return blocks[index]
    }
    
    
}
