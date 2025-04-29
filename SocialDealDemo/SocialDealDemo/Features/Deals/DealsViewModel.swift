//
//  DealsViewModel.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 29/04/2025.
//

import Domain
import Networking

class DealsViewModel {
    private(set) var deals = [Deal]()
    private(set) var fetchingError: Error?
    
    func fetchDeals() async {
        fetchingError = nil
        
        do {
            deals = try await DealsAPI.fetchDeals()
            fetchingError = nil
        } catch {
            deals = []
            fetchingError = error
        }
    }
}
