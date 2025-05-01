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
    
    public init(amount: Decimal, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
    public func formattedString(using currency: Currency?) -> String {
        // Normally our currency just comes from the backend so use the currency in this model,
        // but for this demo this is necessary to reflect the setting
        let currencyToUse = currency ?? self.currency
        let amount = amount * currencyToUse.exchangeRateToEuro
        return "\(currencyToUse.symbol)\(amount.formatToCurrency())"

    }
}
