//
//  DealCollectionCell.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import UIKit

class DealCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "DealCollectionCell"
    
    private enum Constants {
        static let imageViewCornerRadius: CGFloat = 6
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        return imageView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    private let companyLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        return companyLabel
    }()
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    private let soldLabel: UILabel = {
        let soldLabel = UILabel()
        soldLabel.translatesAutoresizingMaskIntoConstraints = false
        soldLabel.numberOfLines = 0
        soldLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        soldLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return soldLabel
    }()
    private let fromPriceLabel: UILabel = {
        let fromPriceLabel = UILabel()
        fromPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return fromPriceLabel
    }()
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    let bottomLabelStack: UIStackView = {
        let bottomLabelStack = UIStackView()
        bottomLabelStack.axis = .horizontal
        bottomLabelStack.spacing = 8
        bottomLabelStack.alignment = .leading
        bottomLabelStack.distribution = .fill
        return bottomLabelStack
    }()
    let priceStackView: UIStackView = {
        let priceStackView = UIStackView()
        priceStackView.axis = .horizontal
        priceStackView.spacing = 8
        return priceStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(bottomLabelStack)
        bottomLabelStack.addArrangedSubview(soldLabel)
        bottomLabelStack.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(fromPriceLabel)
        priceStackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/3),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bottomLabelStack.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            bottomLabelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLabelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    public func configure(with deal: Deal) {
        // TODO: Set the image
        titleLabel.text = deal.title
        companyLabel.text = deal.company
        cityLabel.text = deal.city
        soldLabel.text = deal.soldLabel
        fromPriceLabel.isHidden = deal.prices.fromPrice != nil
        fromPriceLabel.text = deal.prices.fromPrice?.formattedString
        priceLabel.text = deal.prices.price.formattedString
    }
}
