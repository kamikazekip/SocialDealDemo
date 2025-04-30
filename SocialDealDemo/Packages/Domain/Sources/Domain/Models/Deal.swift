//
//  Deal.swift
//  Domain
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

public struct Deal: Codable, Equatable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case unique = "unique"
        case title = "title"
        case image = "image"
        case soldLabel = "sold_label"
        case description = "description"
        case company = "company"
        case city = "city"
        case prices = "prices"
    }
    
    public let unique: String
    public let title: String
    public let image: String
    public let soldLabel: String
    public let company: String
    public let description: String?
    public let city: String
    public let prices: Prices
    
    public init(
        unique: String,
        title: String,
        image: String,
        soldLabel: String,
        company: String,
        description: String?,
        city: String,
        prices: Prices
    ) {
        self.unique = unique
        self.title = title
        self.image = image
        self.soldLabel = soldLabel
        self.company = company
        self.description = description
        self.city = city
        self.prices = prices
    }
}
