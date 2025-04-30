//
//  Currency.swift
//  Domain
//
//  Created by Erik Brandsma on 27/04/2025.
//

public struct Currency: Codable, Equatable, Sendable {
    public let symbol: String
    public let code: String
    
    public init(symbol: String, code: String) {
        self.symbol = symbol
        self.code = code
    }
}
