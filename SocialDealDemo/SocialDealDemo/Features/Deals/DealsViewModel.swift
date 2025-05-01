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
    let showOnlyFavorites: Bool
    private var allDeals = [Deal]()
    private var filteredDeals = [Deal]()
    private(set) var deals = [Deal]()
    private(set) var fetchingError: Error?
    private var currentPrefetch = 20
    
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
            filteredDeals = allDeals.filter { deal in
                favorites.contains(where: { $0 == deal.unique })
            }
        } else {
            filteredDeals = allDeals
        }
        
        prefetchDeals()
    }
    
    func loadMoreItems() -> Bool {
        guard currentPrefetch <= allDeals.count else {
            return false
        }
        currentPrefetch += 20
        prefetchDeals()
        return true
    }
    
    private func prefetchDeals() {
        deals = Array(filteredDeals.prefix(currentPrefetch))
    }
}
