//
//  Transition.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 01/05/2025.
//

import UIKit

protocol Transition {
    var from: UIViewController.Type { get }
    var to: UIViewController.Type { get }
}
