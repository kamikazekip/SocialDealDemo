//
//  DealAPI.swift
//  Networking
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Domain
import Foundation

public class DealAPI {
    public static func fetchDeal(unique: String) async throws -> Deal {
        guard let url = URL(string: "https://media.socialdeal.nl/demo/details.json?id=\(unique)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(Deal.self, from: data)
        return response
    }
}
