//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var transitionDelegate = DemoNavigationControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonTapped(_ sender: Any) {
        navigationController?.delegate = transitionDelegate
        let demo = storyboard!.instantiateViewController(withIdentifier: "Demo")
        navigationController?.pushViewController(demo, animated: true)
    }
    
}

