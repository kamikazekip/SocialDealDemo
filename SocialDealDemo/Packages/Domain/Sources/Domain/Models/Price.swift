//
//  Price.swift
//  Domain
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

public struct Price: Codable, Equatable, Sendable {
    public let amount: Decimal
    public let currency: Currency
    
    public var formattedString: String {
        return "\(currency.symbol)\(amount)"
    }
}
