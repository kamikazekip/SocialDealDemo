//
//  DealsAPI.swift
//  Networking
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import Foundation

public class DealsAPI {
    public static func fetchDeals() async throws -> [Deal] {
        guard let url = URL(string: "https://media.socialdeal.nl/demo/deals.json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(DealsResponse.self, from: data)
        return response.deals
    }
}
