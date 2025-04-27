//
//  Prices.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

struct Prices: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case fromPrice = "from_price"
        case priceLabel = "price_label"
        case discountLabel = "discount_label"
    }
    
    let price: Price
    let fromPrice: Price
    let priceLabel: String?
    let discountLabel: String?
}
