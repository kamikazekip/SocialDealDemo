//
//  DealToDealsTransition.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 01/05/2025.
//

import UIKit

class DealToDealsTransition: NSObject, Transition {
    private enum Constants {
        static let duration: TimeInterval = 0.5
    }
    
    var from: UIViewController.Type { DealViewController.self }
    var to: UIViewController.Type { DealsViewController.self }
}

extension DealToDealsTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        Constants.duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? DealViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? DealsViewController,
            let toImageView = toVC.selectedDealCell?.thumbnailView
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let fromImageView = fromVC.imageView
        
        let containerView = transitionContext.containerView
        toVC.view.alpha = .zero
        containerView.addSubview(toVC.view)

        let snapshot = UIImageView(image: fromImageView.image)
        snapshot.layer.cornerRadius = fromImageView.layer.cornerRadius
        snapshot.clipsToBounds = true
        
        let initialFrame = containerView.convert(fromImageView.frame, from: fromImageView.superview)
        let finalFrame = containerView.convert(toImageView.frame, from: toImageView.superview)
        
        snapshot.frame = initialFrame
        containerView.addSubview(snapshot)
        
        fromImageView.isHidden = true
        toImageView.isHidden = true
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot.frame = finalFrame
                snapshot.layer.cornerRadius = toImageView.layer.cornerRadius
                toVC.view.alpha = 1
            },
            completion: { _ in
                fromImageView.isHidden = false
                toImageView.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
