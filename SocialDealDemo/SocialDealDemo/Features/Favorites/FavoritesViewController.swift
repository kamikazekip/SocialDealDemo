//
//  FavoritesViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    let transitionRepository = TransitionRepository()
    let dealsVC = DealsViewController(viewModel: DealsViewModel(showOnlyFavorites: true))
    lazy var navController = UINavigationController(rootViewController: dealsVC)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navController.delegate = transitionRepository
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dealsVC.refilterDeals()
    }
    
    private func setupView() {
        navigationItem.title = "Favorieten"
        
        addChild(navController)
        
        view.addSubview(navController.view)
        navController.view.frame = view.bounds // or setup constraints
        navController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navController.didMove(toParent: self)
    }
}
