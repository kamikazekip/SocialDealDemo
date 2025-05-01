//
//  AppUserDefaults.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Domain
import Foundation

extension UserDefaults {
    @UserDefault(key: "favorites", defaultValue: [String]()) static var favorites: [String]
    @UserDefault(key: "currency", defaultValue: Currency.euro.symbol) static var currency: String
}
