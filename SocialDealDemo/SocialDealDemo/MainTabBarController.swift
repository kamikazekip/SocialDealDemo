//
//  MainTabBarController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    let deals: UIViewController = {
        let deals = UINavigationController()
        deals.viewControllers = [DealsViewController()]
        deals.tabBarItem = UITabBarItem(
            title: "Deals",
            image: UIImage(systemName: "tag"),
            selectedImage: UIImage(systemName: "tag.fill")
        )
        return deals
    }()
    
    let favorites: UIViewController = {
        let favorites = UINavigationController()
        favorites.viewControllers = [FavoritesViewController()]
        favorites.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        return favorites
    }()
    
    let settings: UIViewController = {
        let settings = UINavigationController()
        settings.viewControllers = [SettingsViewController()]
        settings.tabBarItem = UITabBarItem(
            title: "Settings",
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

