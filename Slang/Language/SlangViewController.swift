//
//  SlangViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import pop
import Cartography

// MARK: - SlangViewController Class

class SlangViewController: UIViewController {

    // MARK: - Properties

    var allTypes: [Block] = [.Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank, .Blank]
    
    let viewModel = SlangViewModel()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        for type in BlockType.allTypes {
            tableView.registerClass(type.tableViewCellClass,
                forCellReuseIdentifier: type.identifier)
        }
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tableView
    }()

    lazy var blocks: [String: DraggableBlock] = {
        var blocks = [String: DraggableBlock]()
        for type in BlockType.allTypes {
            let block = DraggableBlock(type: type)
            block.delegate = self
            blocks[type.identifier] = block
        }
        return blocks
    }()

    var blockCenterPoints = [String: CGPoint]()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        for (key, block) in blocks {
            view.addSubview(block)
        }

        layoutSubviews()
    }

    // MARK: - Layout

    func layoutSubviews() {

        constrain(tableView) { tableView in
            tableView.width == tableView.superview!.width
            tableView.height == tableView.superview!.height * 0.5
            tableView.top == tableView.superview!.top
        }

        layoutBlocks()
    }

    func layoutBlocks() {

        let columnLength = 3
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 20
        let blockWidth: CGFloat = iPhone6Or6Plus ? 106.0 : 88.0
        let blockHeight: CGFloat = 35.0

        var posX: CGFloat = 20.0
        var posY: CGFloat = self.view.frame.size.height * 0.5 + 30

        for i in [0,3] {

            for j in 0..<columnLength {
                let type = BlockType(rawValue: j + i)!
                let block = blocks[type.identifier]!
                let frame = CGRectMake(posX, posY, blockWidth, blockHeight)
                block.frame = frame
                blockCenterPoints[type.identifier] = block.center
                posX += (blockWidth + horizontalSpacing)
            }

            posX = 20
            posY += (blockHeight + verticalSpacing)
        }

        // Final Block, 7 Blocks in total
        // so this goes in the center of the last row
        posX += blockWidth + horizontalSpacing
        let frame = CGRectMake(posX, posY, blockWidth, blockHeight)
        let type = BlockType.Print
        let block = blocks[type.identifier]!
        block.frame = frame
        blockCenterPoints[type.identifier] = block.center
    }
}

// MARK: - UITableView DataSource & Delegate Methods

extension SlangViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blockCount
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let block = allTypes[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(block.type.identifier, forIndexPath: indexPath) as SLTableViewCell
        cell.lineNumber = "\(indexPath.row + 1)"
        cell.configureWithBlock(block)
        
        if contains(BlockType.editableTypes, block.type) {
           cell.delegate = self
        }
        
        return cell
    }
}

// MARK: - DraggableBlock Delegate

extension SlangViewController: DraggableBlockDelegate {
    
    func draggableBlock(panGestureDidFinishWithDraggableBlock draggableBlock: DraggableBlock) {

        let visibleCells = tableView.visibleCells()

        for cell in visibleCells {

            let cellframe = tableView.convertRect(cell.frame, toView: self.view)

            if CGRectIntersectsRect(cellframe, draggableBlock.frame) {
                if let indexPath = tableView.indexPathForCell(cell as UITableViewCell) {
                    
                    let centerPoint = blockCenterPoints[draggableBlock.type.identifier]!
                    let anim = createCenterAnimation(toPoint: centerPoint)
                    draggableBlock.pop_addAnimation(anim, forKey: "center")
                    
                    allTypes[indexPath.row] = Block.createBlock(draggableBlock.type)
                    tableView.reloadData()
                }
            }
        }
    }
    
    func createCenterAnimation(toPoint point: CGPoint) -> POPSpringAnimation {
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim.springBounciness = 5
        anim.springSpeed = 5
        anim.toValue = NSValue(CGPoint: point)
        return anim
    }
}

// MARK: - DraggableBlock Delegate

extension SlangViewController: SLTableViewCellDelegate {
    
    func tableViewCell(tableViewCellAtIndex index: Int, didUpdateWithBlock block: Block) {
        allTypes[index] = block
        
        for block in allTypes {
            println(block.description)
        }
    }
}

