//
//  Price.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Foundation

struct Price: Codable, Equatable {
    let amount: Decimal
    let currency: Currency
    
    var formattedString: String {
        return "\(currency.symbol)\(amount)"
    }
}
