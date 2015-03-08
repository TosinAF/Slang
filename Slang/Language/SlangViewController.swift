//
//  SlangViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit
import Cartography
import AHKBendableView


// MARK: - SlangViewController Class

class SlangViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel = SlangViewModel()
    var blockCenterPoints = [String: CGPoint]()
    let consoleLayoutGroup = ConstraintGroup()
    
    // MARK: - Views
    
    lazy var navigationBar: UINavigationBar = {
        let image = UIImage(named: "SlangLogo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        
        let navItem = UINavigationItem(title: "Slang")
        navItem.titleView = imageView
        navItem.leftBarButtonItem = UIBarButtonItem(customView: self.dismissButton)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: self.executeButton)
        
        let navigationBar = UINavigationBar()
        navigationBar.pushNavigationItem(navItem, animated: false)
        navigationBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        return navigationBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        for type in BlockType.allTypes {
            tableView.registerClass(type.tableViewCellClass,
                forCellReuseIdentifier: type.identifier)
        }
        tableView.backgroundColor = UIColor.PrimaryBrandColor()
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
    
    lazy var executeButton: UIButton = {
        let button = UIButton(frame: CGRectMake(0, 0, 24, 24))
        button.backgroundColor = UIColor.PrimaryBrandColor()
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 10
        button.layer.cornerRadius = 12
        button.addTarget(self, action: "executeButtonTapped", forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(frame: CGRectMake(0, 0, 24, 24))
        button.setTitle("\u{274C}", forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Entypo", size: 60.0)
        button.addTarget(self, action: "onDismissButtonTap", forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var consoleView: ConsoleView = {
        let consoleView = ConsoleView(frame: CGRectZero)
        consoleView.dismissButtonAction = { () in
            self.hideConsoleView()
        }
        consoleView.fillColor = UIColor.PrimaryBrandColor()
        consoleView.damping = 0.7
        consoleView.initialSpringVelocity = 0.8
        consoleView.alpha = 0.0
        consoleView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return consoleView
    }()

    // MARK: - View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        title = "Slang"
        
        view.backgroundColor = UIColor.PrimaryBrandColor()
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        view.addSubview(consoleView)
        
        for (key, block) in blocks {
            view.addSubview(block)
        }
        
        layoutSubviews()
        
        let tap = UITapGestureRecognizer(target: self, action:"dismissKeyboardAndConsole")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    // MARK: - Layout

    func layoutSubviews() {
        
        constrain(navigationBar) { navigationBar in
            navigationBar.width == navigationBar.superview!.width
            navigationBar.height == 64
            navigationBar.top == navigationBar.superview!.top
        }

        constrain(tableView, navigationBar) { tableView, navigationBar in
            tableView.width == tableView.superview!.width
            tableView.height == tableView.superview!.height * 0.5 - 64
            tableView.top == navigationBar.bottom
        }
        
        constrain(consoleView) { consoleView in
            consoleView.width == consoleView.superview!.width
            consoleView.height == consoleView.superview!.height * 0.5
            consoleView.left == consoleView.superview!.left
        }
        
        constrain(consoleView, replace: consoleLayoutGroup) { consoleView in
            consoleView.top == consoleView.superview!.bottom; return
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
        var posY: CGFloat = self.view.frame.size.height * 0.5 + 34

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
    
    // MARK: - Actions
    
    func executeButtonTapped() {
        view.endEditing(true)
        let log = viewModel.execute()
        println(log)
        consoleView.log = log
        displayConsoleView()
    }
    
    func dismissKeyboardAndConsole() {
        view.endEditing(true)
        hideConsoleView()
    }
    
    func onDismissButtonTap() {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
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
        
        let block = viewModel.block(atIndex: indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(block.type.identifier, forIndexPath: indexPath) as SLTableViewCell
        
        cell.lineNumber = "\(indexPath.row + 1)"
        cell.configureWithBlock(block)
        
        if contains(BlockType.editableTypes, block.type) {
           cell.delegate = self
        }
        
        return cell
    }
}

// MARK: - View Animations 

extension SlangViewController {
    
    func displayConsoleView() {
        
        consoleView.alpha = 1.0
        view.bringSubviewToFront(consoleView)
        
        constrain(consoleView, tableView, replace: consoleLayoutGroup) { consoleView, tableView in
            consoleView.top == tableView.bottom + 30; return
        }
        
        animateConsoleViewLayout()
    }
    
    func hideConsoleView() {
        
        constrain(consoleView, tableView, replace: consoleLayoutGroup) { consoleView, tableView in
            consoleView.top == consoleView.superview!.bottom; return
        }
        
        animateConsoleViewLayout()
        delay(0.5, { () -> () in
            self.consoleView.alpha = 0.0
        })
    }
    
    private func animateConsoleViewLayout() {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.9,
            options: .BeginFromCurrentState | .AllowUserInteraction,
            animations: {
                self.view.layoutIfNeeded()
            }, completion: nil
        )
    }
}

// MARK: - DraggableBlock Delegate

extension SlangViewController: DraggableBlockDelegate {
    
    func draggableBlock(panGestureDidFinishWithDraggableBlock draggableBlock: DraggableBlock) {

        let visibleCells = tableView.visibleCells()
        for cell in visibleCells {
            
            let cellframe = tableView.convertRect(cell.frame, toView: self.view)
            
            if CGRectIntersectsRect(cellframe, draggableBlock.frame) {
                
                animateDraggableBlockReturn(draggableBlock)
                
                let indexPath = tableView.indexPathForCell(cell as UITableViewCell)!
                let block = Block.createBlock(draggableBlock.type)
                viewModel.updateBlock(atIndex: indexPath.row, withBlock: block)
                tableView.reloadData()
                break
            }
        }
        
        animateDraggableBlockReturn(draggableBlock)
    }
    
    func animateDraggableBlockReturn(draggableBlock: DraggableBlock) {
        let centerPoint = blockCenterPoints[draggableBlock.type.identifier]!
        let anim = createCenterAnimation(toPoint: centerPoint)
        draggableBlock.pop_addAnimation(anim, forKey: "center")
    }
    
    func createCenterAnimation(toPoint point: CGPoint) -> POPSpringAnimation {
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        anim.springBounciness = 5
        anim.springSpeed = 5
        anim.toValue = NSValue(CGPoint: point)
        return anim
    }
}

// MARK: - SLTableViewCellDelegate

extension SlangViewController: SLTableViewCellDelegate {
    
    func tableViewCell(tableViewCellAtIndex index: Int, didUpdateWithBlock block: Block) {
        viewModel.updateBlock(atIndex: index, withBlock: block)
    }
}

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview)? {
                return imageView
            }
        }
        
        return nil
    }
    
}

