//
//  AppUserDefaults.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: "favorites", defaultValue: [String]()) static var favorites: [String]
}
