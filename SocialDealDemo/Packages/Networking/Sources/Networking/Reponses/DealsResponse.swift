//
//  DealsResponse.swift
//  Networking
//
//  Created by Erik Brandsma on 29/04/2025.
//

import Domain

public struct DealsResponse: Codable, Equatable, Sendable {
    public enum CodingKeys: String, CodingKey {
        case numberOfDeals = "num_deals"
        case deals = "deals"
    }
    
    public let numberOfDeals: Int
    public let deals: [Deal]
}
