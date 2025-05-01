//
//  Decimal+Formatting.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 01/05/2025.
//

import Foundation

extension Decimal {
    func isInteger() -> Bool {
        var value = self
        var rounded = Decimal()
        NSDecimalRound(&rounded, &value, 0, .down)
        return self == rounded
    }
        
    func formatToCurrency() -> String {
        let isInteger = self.isInteger()
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = isInteger ? 0 : 2
        formatter.maximumFractionDigits = isInteger ? 0 : 2
        formatter.usesGroupingSeparator = false
        
        return formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
    }
}
