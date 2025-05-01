//
//  MainTabBarController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import UIKit

class MainTabBarController: UITabBarController {
    private let transitionRepository = TransitionRepository()
    
    lazy var deals: UIViewController = {
        let vc = DealsViewController()
        let deals = UINavigationController(rootViewController: vc)
        deals.delegate = transitionRepository
        deals.tabBarItem = UITabBarItem(
            title: "Deals",
            image: UIImage(systemName: "tag"),
            selectedImage: UIImage(systemName: "tag.fill")
        )
        return deals
    }()
    
    lazy var favorites: UIViewController = {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(
            title: "Favorieten",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        return favoritesVC
    }()
    
    let settings: UIViewController = {
        let settings = UINavigationController()
        settings.viewControllers = [SettingsViewController()]
        settings.tabBarItem = UITabBarItem(
            title: "Instellingen",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        return settings
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            deals,
            favorites,
            settings
        ]
    }
}

