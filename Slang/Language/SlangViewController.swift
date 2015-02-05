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
            block.setTranslatesAutoresizingMaskIntoConstraints(false)
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

        var views = blocks as [String: UIView]
        views["tableView"] = tableView

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[blank(==variable)]-[variable]-[repeat(==variable)]-20-|", options: .AlignAllCenterY, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[if(==else)]-[else]-[end(==else)]-20-|", options: .AlignAllCenterY, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[print(==else)]", options: .AlignAllCenterY, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tableView]-30-[blank]-20-[if]-20-[print]", options: nil, metrics: nil, views: views))

        let printBlock = blocks[BlockType.SLPrint.identifier]!
        constrain(printBlock) { printBlock in
            printBlock.centerX == printBlock.superview!.centerX; return
        }
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
