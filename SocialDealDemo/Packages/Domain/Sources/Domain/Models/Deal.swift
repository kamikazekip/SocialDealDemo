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
        case company = "company"
        case city = "city"
        case prices = "prices"
    }
    
    public let unique: String
    public let title: String
    public let image: String
    public let soldLabel: String
    public let company: String
    public let city: String
    public let prices: Prices
}
