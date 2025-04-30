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
        
        activityIndicator.constraintToCenter(of: self)
    }
    
    @discardableResult
    public func load(_ image: String) -> Task<Void, Never> {
        activityIndicator.isHidden = false
        return Task { [weak self] in
            do {
                let data = try await ImageAPI.shared.fetchImage(image)
                DispatchQueue.main.async {
                    self?.setImage(data)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.activityIndicator.isHidden = true
                    // TODO: Set image to an error
                }
            }
        }
    }
    
    public func setImage(_ image: Data) {
        setImage(UIImage(data: image))
    }
    
    public func setImage(_ image: UIImage?) {
        self.image = image
        activityIndicator.isHidden = true
    }
}
