//
//  UserDefaultsPW.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    public var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        } set {
            container.set(newValue, forKey: key)
        }
    }
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
