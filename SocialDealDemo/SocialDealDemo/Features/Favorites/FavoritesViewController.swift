//
//  FavoritesViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    let child = DealsViewController(viewModel: DealsViewModel(showOnlyFavorites: true))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        child.refilterDeals()
    }
    
    private func setupView() {
        navigationItem.title = "Favorites"
        
        addChild(child)
        
        view.addSubview(child.view)
        child.view.frame = view.bounds // or setup constraints
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
}
