//
//  DealViewModel.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Domain
import Foundation
import Networking

class DealViewModel {
    private(set) var initialDeal: Deal
    
    init(initialDeal: Deal) {
        self.initialDeal = initialDeal
    }
    
    public func fetchImageFromCache() async -> Data? {
        await ImageAPI.shared.fetchImageFromCache(initialDeal.image)
    }
    
    public func fetchFullDeal() async throws -> Deal {
        // I added this delay for demonstration purposes, this way you can see the view correctly shows a waiting indicator where it should (The call usually is too fast to see this)
        try? await Task.sleep(nanoseconds: 500_000_000)
        return try await DealAPI.fetchDeal(unique: initialDeal.unique)
    }
}
