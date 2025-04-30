//
//  LazyLoadingImageView.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Networking
import UIKit

public class LazyLoadingImageView: UIImageView {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(activityIndicator)
    }
    
    public func load(_ image: String) {
        activityIndicator.isHidden = false
        Task { [weak self] in
            do {
                let data = try await ImageAPI.shared.fetchImage(image)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.image = image
                }
            } catch {
                // TODO: Set image to an error
            }
            
            self?.activityIndicator.isHidden = true
        }
    }
}
