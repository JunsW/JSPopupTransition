//
//  MTableViewDelegate.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let demo = storyboard!.instantiateViewController(withIdentifier: "Demo")
        let rect = tableView.convert(tableView.rectForRow(at: indexPath), to: self.view)
        print("\(rect.origin)")
        selectedOrigin = rect.origin
        navigationController?.delegate = transitionDelegate
        navigationController?.pushViewController(demo, animated: true)
    }
}