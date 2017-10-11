//
//  Transition.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class DemoCustomTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    var fisrtStepHeight: CGFloat = 0
    var duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration // 动画时长
    }
    func animationEnded(_ transitionCompleted: Bool) {
        print("Done")
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let container = transitionContext.containerView
        let toView = toViewController.view
        let fromView = fromViewController.view
        let originalFrame = toView?.frame
        let screentHeight = UIScreen.main.bounds.height
        container.addSubview(toView!)

        
        if fromViewController.isKind(of: MainTableViewController.self) {
            let controller = fromViewController as! MainTableViewController
            let y = controller.selectedOrigin.y
            let rowHeight = controller.rowHeight
            let offset = y+64-screentHeight/2+rowHeight/2
            let ratio = rowHeight/screentHeight
            
            toView?.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: (toView?.frame.size)!)
            (toViewController as! DemoViewController).fromViewOffset = offset // TODO: guard
            let duration = transitionDuration(using: transitionContext)
            toView?.transform = CGAffineTransform(scaleX: 1, y: ratio)
            //        fromView?.alpha = 1
            let partOneDuration = duration * 0.77
            let partTwoDuration = duration - partOneDuration
            animate(view: toView!, stepOneRatio: ratio*1.2, stepTwoRatio: 1, stepOneDuration: partOneDuration, stepTwoDuration: partTwoDuration, isBack: false, backOffset: 0, finalFrame: originalFrame!) {
                transitionContext.completeTransition(true)
            }
            
        } else if fromViewController.isKind(of: DemoViewController.self){
            // 返回
            let controller = toViewController as! MainTableViewController
            let rowHeight = controller.rowHeight

            let offset = (fromViewController as! DemoViewController).fromViewOffset!
            let ratio = rowHeight/screentHeight

            let duration = transitionDuration(using: transitionContext)
            transitionContext.containerView.bringSubview(toFront: fromView!)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                fromView!.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: UIScreen.main.bounds.size)
                fromView!.transform = CGAffineTransform(scaleX: 1, y: ratio)
            }) { _ in
                fromView?.alpha = 0
                transitionContext.completeTransition(true)
        }
       
        
        }
        
    }
    /**
     - Parameters:
         - view: 进行动画的视图
         - stepOneRatio: 第一步缩放的比例
         - stepTwoRatio: 第二步缩放的比例
         - stepOneDuration: 第一步动画的时间
         - stepTwoDuration: 第二步动画的时间
         - stepTwoFade: 第二步透明度变化
         - isBack: 是否是返回
         - backOffset: 返回时View的偏移量
         - finalFrame: 控制器初识frame，用来还原位置
         - completion: 完成之后调用的闭包
     */
    private func animate(view: UIView, stepOneRatio: CGFloat, stepTwoRatio: CGFloat, stepOneDuration: TimeInterval, stepTwoDuration: TimeInterval, isBack: Bool, backOffset offset: CGFloat, finalFrame: CGRect, completion: @escaping () -> ()) {
        UIView.animate(withDuration: stepOneDuration, delay: 0, options: .curveEaseOut, animations: {
            if isBack { view.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) }
            view.transform = CGAffineTransform(scaleX: 1, y: stepOneRatio)

        }) { _ in
            UIView.animate(withDuration: stepTwoDuration, delay: 0, options: .curveEaseOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: stepTwoRatio)
                if isBack { view.alpha = 0 } else {
                    view.frame = finalFrame
                }
            }) { _ in
                //                fromView?.alpha = 1
                completion()
            }
            
        }
    }
}
