//
//  TransitionRepository.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 01/05/2025.
//

import UIKit

final class TransitionRepository: NSObject, UINavigationControllerDelegate {
    private let transitions: [Transition & UIViewControllerAnimatedTransitioning] = [
        DealsToDealTransition(),
        DealToDealsTransition()
    ]
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transitions.first { $0.from == type(of: fromVC) && $0.to == type(of: toVC) }
    }
}
