//
//  DealsToDealTransition.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 01/05/2025.
//

import UIKit

class DealsToDealTransition: NSObject, Transition {
    private enum Constants {
        static let duration: TimeInterval = 0.5
    }
    
    var from: UIViewController.Type { DealsViewController.self }
    var to: UIViewController.Type { DealViewController.self }
}

extension DealsToDealTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        Constants.duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? DealsViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? DealViewController,
            let cell = fromVC.selectedDealCell
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = .zero
        containerView.addSubview(toVC.view)
        toVC.view.layoutIfNeeded()

        let fromImageView = cell.thumbnailView
        let toImageView = toVC.imageView
        let snapshot = UIImageView(image: fromImageView.image)
        snapshot.layer.cornerRadius = fromImageView.layer.cornerRadius
        snapshot.clipsToBounds = true
        
        let initialFrame = containerView.convert(fromImageView.frame, from: fromImageView.superview)
        let finalFrame = containerView.convert(toImageView.frame, from: toImageView.superview)
        
        snapshot.frame = initialFrame
        containerView.addSubview(snapshot)
        
        cell.favoriteButton.isHidden = true
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
                cell.favoriteButton.isHidden = false
                fromImageView.isHidden = false
                toImageView.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
