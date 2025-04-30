//
//  DealTableViewCell.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import UIKit

final class InsetsGroupedLayer: CALayer {
    override var cornerRadius: CGFloat {
        get { .standardPadding }
        set { }
    }
}

class DealTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DealCollectionCell"
    
    private enum Constants {
        static let imageViewCornerRadius: CGFloat = 12
        static let imageViewAspectRatio: CGFloat = 3/5
        static let titleLabelSizeIncrease: CGFloat = 8
        static let priceLabelSizeIncrease: CGFloat = 10
        static let baseOffsetDecimals: CGFloat = 3
    }
    
    override class var layerClass: AnyClass {
        InsetsGroupedLayer.self
    }
    
    private let thumbnailView: LazyLoadingImageView = {
        let thumbnailView = LazyLoadingImageView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.layer.cornerRadius = Constants.imageViewCornerRadius
        thumbnailView.clipsToBounds = true
        return thumbnailView
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart")
        button.setImage(heartImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize + Constants.titleLabelSizeIncrease)
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    private let companyLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        companyLabel.numberOfLines = .zero
        companyLabel.textColor = UIColor.secondaryLabelColor
        return companyLabel
    }()
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        cityLabel.numberOfLines = .zero
        cityLabel.textColor = UIColor.secondaryLabelColor
        return cityLabel
    }()
    private let soldLabel: UILabel = {
        let soldLabel = UILabel()
        soldLabel.translatesAutoresizingMaskIntoConstraints = false
        soldLabel.numberOfLines = .zero
        soldLabel.textColor = UIColor.soldLabelColor
        soldLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        soldLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        soldLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return soldLabel
    }()
    private let fromPriceLabel: UILabel = {
        let fromPriceLabel = UILabel()
        fromPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        fromPriceLabel.setContentHuggingPriority(.required, for: .horizontal)
        fromPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return fromPriceLabel
    }()
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return priceLabel
    }()
    let bottomLabelStack: UIStackView = {
        let bottomLabelStack = UIStackView()
        bottomLabelStack.translatesAutoresizingMaskIntoConstraints = false
        bottomLabelStack.axis = .horizontal
        bottomLabelStack.spacing = .standardPadding
        bottomLabelStack.alignment = .center
        bottomLabelStack.distribution = .fillProportionally
        return bottomLabelStack
    }()
    let priceStackView: UIStackView = {
        let priceStackView = UIStackView()
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.axis = .horizontal
        priceStackView.spacing = .standardPadding
        return priceStackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(thumbnailView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(bottomLabelStack)
                
        bottomLabelStack.addArrangedSubview(soldLabel)
        bottomLabelStack.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(fromPriceLabel)
        priceStackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor, multiplier: Constants.imageViewAspectRatio),
            
            favoriteButton.bottomAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: -.standardPadding * 2),
            favoriteButton.trailingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: -.standardPadding * 2),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: .standardPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .standardPadding),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            bottomLabelStack.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: .standardPadding),
            bottomLabelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLabelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLabelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configure(with deal: Deal) {
        // TODO: Set the image
        thumbnailView.load(deal.image)
        titleLabel.text = deal.title
        companyLabel.text = deal.company
        cityLabel.text = deal.city
        soldLabel.text = deal.soldLabel
        fromPriceLabel.isHidden = deal.prices.fromPrice == nil
        fromPriceLabel.attributedText = fromPriceLabelAttributedText(deal.prices.fromPrice?.formattedString)
        priceLabel.attributedText = priceLabelAttributedText(deal.prices.price.formattedString)
    }
    
    private func fromPriceLabelAttributedText(_ text: String?) -> NSAttributedString? {
        guard let text else {
            return nil
        }
        
        return NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.secondaryLabelColor ?? .systemGray
        ])
    }
    
    private func priceLabelAttributedText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize + Constants.priceLabelSizeIncrease),
            .foregroundColor: UIColor.priceLabelColor ?? .systemGreen
        ])
        
        if let separatorIndex = text.firstIndex(where: { [".", ","].contains($0) }) {
            let location = text.distance(from: text.startIndex, to: separatorIndex)
            let distance = text.distance(from: separatorIndex, to: text.endIndex)
            attributedString.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
                .baselineOffset: Constants.baseOffsetDecimals
            ], range: NSRange(location: location, length: distance))
        }
        
        return attributedString
    }
}
