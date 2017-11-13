//
//  Transition.swift
//  CustomTransitionDemo
//
//  Created by 王俊硕 on 2017/10/11.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class JSTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    var fisrtStepHeight: CGFloat = 0
    var duration = 0.5
    
    let imageSets = ["duck", "squirrel", "fish", "unknown", "rabbit"]
    let titleSets = ["duck", "squirrel", "fish", "unknown", "rabbit"]
    let descriptionSets = ["a duck", "a squirrel", "a fish", "unknown monster", "a rabbit"]
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration // 动画时长
    }
    func animationEnded(_ transitionCompleted: Bool) {
        print("Done")
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let fromView = fromViewController.view!
        let toView = toViewController.view!

        let container = transitionContext.containerView
        
        let originalFrame = toView.frame
        let screenWidth = UIScreen.main.bounds.width
        let screentHeight = UIScreen.main.bounds.height
        
        
        container.addSubview(toView)
        
        
        if fromViewController.isKind(of: MainTableViewController.self) {
            let fromController = fromViewController as! MainTableViewController
            let toController = toViewController as! DestinationViewController
            
            let selectedIndex = fromController.selectedIndexPath!
            toController.setup(title: titleSets[selectedIndex.row], imageName: imageSets[selectedIndex.row], description: descriptionSets[selectedIndex.row])
            
            let navigationBarOffset = CGFloat(64) // Add the navigation bar height
            // calulte the position
            let originalY = fromController.selectedOrigin.y + navigationBarOffset
            let rowHeight = fromController.rowHeight
            let scrollOffsetY = fromController.contentView.contentOffset.y + 64
            print(scrollOffsetY)
            let offset = originalY+64-screentHeight/2+rowHeight/2-scrollOffsetY
            let ratio = rowHeight/screentHeight
            
            // add a animation mask view   the same frame as the cell
            let maskView = UIImageView(image: UIImage(named: imageSets[selectedIndex.row]))
            maskView.frame = CGRect(x: 0, y: originalY, width: screenWidth, height: 300) // row height
            container.addSubview(maskView)
            
            toView.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: (toView.frame.size))
            (toController).fromViewOffset = offset
            let duration = transitionDuration(using: transitionContext)
            toView.transform = CGAffineTransform(scaleX: 1, y: ratio)

            let stepOneDuration = duration * 0.77
            let stepTwoDuration = duration - stepOneDuration
            let stepOneRatio = ratio*1.2
            let stepTwoRatio = CGFloat(1.0)
            
            UIView.animate(withDuration: stepOneDuration, delay: 0, options: .curveEaseOut, animations: {
                toView.transform = CGAffineTransform(scaleX: 1, y: stepOneRatio)
                // move maskView to the top
                maskView.frame.origin = CGPoint(x: 0, y: navigationBarOffset) // UINavigationController bar
            }) { _ in
                UIView.animate(withDuration: stepTwoDuration, delay: 0, options: .curveEaseOut, animations: {
                    toView.transform = CGAffineTransform(scaleX: 1, y: stepTwoRatio)
                    toView.frame = originalFrame
                }) { _ in
                    maskView.removeFromSuperview() // remove maskView
                    transitionContext.completeTransition(true)
                }
            }
        } else if fromViewController.isKind(of: DestinationViewController.self){
            // back
            let controller = toViewController as! MainTableViewController
            let rowHeight = controller.rowHeight

            let offset = (fromViewController as! DestinationViewController).fromViewOffset!
            let ratio = rowHeight/screentHeight

            let duration = transitionDuration(using: transitionContext)
            transitionContext.containerView.bringSubview(toFront: fromView)
            
            let firstStepDuration = duration * 0.2
            let secondStepDuration = duration - firstStepDuration
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: firstStepDuration) {
                    fromView.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: UIScreen.main.bounds.size)
                    fromView.transform = CGAffineTransform(scaleX: 1, y: ratio)
                }
                UIView.addKeyframe(withRelativeStartTime: firstStepDuration, relativeDuration: secondStepDuration) {
                    fromView.alpha = 0
                }
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
}
