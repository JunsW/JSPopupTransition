//
//  MainTableViewController.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {

    var transitionDelegate = JSPopupNavigationControllerDelegate()

    @IBOutlet var contentView: UITableView!
    var selectedOrigin: CGPoint!
    let rowHeight = CGFloat(120)
    
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
