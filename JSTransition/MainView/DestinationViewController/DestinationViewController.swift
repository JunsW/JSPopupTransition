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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maskView = UIView()
        maskView!.frame = view.frame
        maskView!.backgroundColor = .white
        view.addSubview(maskView!)
    }
    override func viewDidAppear(_ animated: Bool) {
        maskView?.removeFromSuperview()

    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setup(title: String, imageName image: String, description: String) {
        titleLabel.text = title
        coverImageView.image = UIImage(named: image)
        descriptionLabel.text = description
    }
    
}
