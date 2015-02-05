//
//  SlangViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

// MARK: - SlangViewController Class

class SlangViewController: UIViewController {

    // MARK: - Properties

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
            blocks[type.identifier] = block
        }
        return blocks
    }()

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
                posX += (blockWidth + horizontalSpacing)
            }

            posX = 20
            posY += (blockHeight + verticalSpacing)
        }

        // Final Block, 7 Blocks in total
        // so this goes in the center of the last row
        posX += blockWidth + horizontalSpacing
        let frame = CGRectMake(posX, posY, blockWidth, blockHeight)
        let type = BlockType.SLPrint
        let block = blocks[type.identifier]!
        block.frame = frame
    }
}

// MARK: - UITableView DataSource & Delegate Methods

extension SlangViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("print", forIndexPath: indexPath) as SLPrintTableViewCell
        cell.lineNumber = "\(indexPath.row + 1)"
        return cell
    }
}
