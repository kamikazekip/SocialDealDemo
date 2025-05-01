//
//  Currency.swift
//  Domain
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

public struct Currency: Codable, Equatable, Sendable {
    public let symbol: String
    public let code: String
    
    public init(symbol: String, code: String) {
        self.symbol = symbol
        self.code = code
    }
    
    public var title: String {
        switch symbol {
        case "€":
            return "Euro"
            
        case "$":
            return "United States Dollar"
            
        default:
            return code
        }
    }
    
    public var exchangeRateToEuro: Decimal {
        switch symbol {
        case "€":
            return Decimal(1)
            
        case "$":
            return Decimal(1.13)
            
        default:
            return Decimal(1)
        }
    }
}

extension Currency {
    public static let euro = Currency(symbol: "€", code: "EUR")
    public static let dollar = Currency(symbol: "$", code: "USD")
    public static let options: [Currency] = [.euro, .dollar]
    
    public static func getCurrencyFromSymbol(_ symbol: String) -> Currency? {
        options.first(where: { $0.symbol == symbol })
    }
}
