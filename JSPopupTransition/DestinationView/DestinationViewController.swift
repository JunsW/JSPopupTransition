//
//  DemoViewController.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit
class DestinationViewController: UIViewController {
    var fromViewOffset: CGFloat?
    var maskView: UIView?
//    var maskViewColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maskView = UIView()
        maskView!.frame = view.frame
        maskView!.backgroundColor = .white
        view.addSubview(maskView!)
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.maskView!.alpha = 0
        }) { _ in
            self.maskView!.removeFromSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
