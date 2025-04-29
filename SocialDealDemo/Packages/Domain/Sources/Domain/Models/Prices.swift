//
//  Prices.swift
//  Domain
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

public struct Prices: Codable, Equatable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case price = "price"
        case fromPrice = "from_price"
        case priceLabel = "price_label"
        case discountLabel = "discount_label"
    }
    
    public let price: Price
    public let fromPrice: Price?
    public let priceLabel: String?
    public let discountLabel: String?
}
