//
//  ImageAPI.swift
//  Networking
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Domain
import Foundation

public actor ImageAPI {
    public static let shared = ImageAPI()
    
    private var cache: [String: Data] = [:]

    private init() {
    }
    
    public func fetchImage(_ image: String) async throws -> Data {
        if let cachedData = cache[image] {
            return cachedData
        }
        
        guard let url = URL(string: "https://images.socialdeal.nl\(image)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        cache[image] = data
        return data
    }
}
