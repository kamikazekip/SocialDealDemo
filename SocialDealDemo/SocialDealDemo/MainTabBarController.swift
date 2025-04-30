//
//  MainTabBarController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import UIKit

class MainTabBarController: UITabBarController {
    let deals: UIViewController = {
        let vc = DealsViewController()
//        let vc = DealViewController(
//            initialDeal: Deal(
//                unique: "x6ji36jvyi4mj9fk",
//                title: "Bioscoopticket + popcorn + drankje bij Corendon Cinema",
//                image: "/deal/corendon-village-hotel-amsterdam-22113009143271.jpg",
//                soldLabel: "Verkocht: 19",
//                company: "Corendon Village Hotel Amsterdam",
//                description: nil,
//                city: "Badhoevedorp (7 km)",
//                prices: Prices(
//                    price: Price(
//                        amount: 1250.000000,
//                        currency: Currency(
//                            symbol: "€",
//                            code: "EUR"
//                        )
//                    ),
//                    fromPrice: Price(
//                        amount: 1700.000000,
//                        currency: Currency(
//                            symbol: "€",
//                            code: "EUR"
//                        )
//                    ),
//                    priceLabel: nil,
//                    discountLabel: "26%"
//                )
//            )
//        )
        let deals = UINavigationController(rootViewController: vc)
        deals.tabBarItem = UITabBarItem(
            title: "Deals",
            image: UIImage(systemName: "tag"),
            selectedImage: UIImage(systemName: "tag.fill")
        )
        return deals
    }()
    
    let favorites: UIViewController = {
        let favoritesVC = FavoritesViewController()
        let favorites = UINavigationController(rootViewController: favoritesVC)
        
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

