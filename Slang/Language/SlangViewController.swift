//
//  SlangViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

class SlangViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Utility Methods

    func configureTableView() {
        tableView.separatorStyle = .None
        for type in BlockType.allTypes {
            tableView.registerClass(type.tableViewCellClass, forCellReuseIdentifier: type.identifier)
        }
    }
}

extension SlangViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("print", forIndexPath: indexPath) as SLPrintTableViewCell
        cell.lineNumber = "\(indexPath.row + 1)"
        return cell
    }

}
