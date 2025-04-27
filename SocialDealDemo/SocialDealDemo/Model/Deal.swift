//
//  Deal.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

struct Deal: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case unique = "unique"
        case title = "title"
        case image = "image"
        case soldLabel = "sold_label"
        case company = "company"
        case city = "city"
        case prices = "prices"
    }
    
    let unique: String
    let title: String
    let image: String
    let soldLabel: String
    let company: String
    let city: String
    let prices: Prices
}
