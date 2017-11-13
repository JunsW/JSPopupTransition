//
//  MainTableViewController.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {

    var transitionDelegate = JSNavigationControllerDelegate()

    @IBOutlet var contentView: UITableView!
    var selectedOrigin: CGPoint!
    var selectedCellColor: UIColor!
    var selectedIndexPath: IndexPath!
    
    
    let imageSets = ["duck", "squirrel", "fish", "unknown", "rabbit"]
    let titleSets = ["duck", "squirrel", "fish", "unknown", "rabbit"]
    let descriptionSets = ["a duck", "a squirrel", "a fish", "unknown monster", "a rabbit"]
    let rowHeight = CGFloat(300)
    let cellColors: [UIColor] = [.yellow, .black, .red, .cyan, .blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        contentView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
