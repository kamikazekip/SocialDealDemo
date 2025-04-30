//
//  DealsViewModel.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 29/04/2025.
//

import Domain
import Networking
import Foundation

class DealsViewModel {
    private let showOnlyFavorites: Bool
    private var allDeals = [Deal]()
    private(set) var deals = [Deal]()
    private(set) var fetchingError: Error?
    
    init(showOnlyFavorites: Bool = false) {
        self.showOnlyFavorites = showOnlyFavorites
    }
    
    func fetchDeals() async {
        fetchingError = nil
        
        do {
            allDeals = try await DealsAPI.fetchDeals()
            filterDeals()
            fetchingError = nil
        } catch {
            deals = []
            fetchingError = error
        }
    }
    
    func filterDeals() {
        if showOnlyFavorites {
            let favorites = UserDefaults.favorites
            deals = allDeals.filter { deal in
                favorites.contains(where: { $0 == deal.unique })
            }
            return
        } else {
            deals = allDeals
        }
    }
}
