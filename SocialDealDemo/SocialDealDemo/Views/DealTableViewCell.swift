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
    
    private var deal: Deal?
    
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
    
    private var imageLoadTask: Task<Void, Never>?
    let thumbnailView: LazyLoadingImageView = {
        let thumbnailView = LazyLoadingImageView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.layer.cornerRadius = Constants.imageViewCornerRadius
        thumbnailView.clipsToBounds = true
        return thumbnailView
    }()
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
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
        companyLabel.textColor = UIColor.secondaryDealLabelColor
        return companyLabel
    }()
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        cityLabel.numberOfLines = .zero
        cityLabel.textColor = UIColor.secondaryDealLabelColor
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    public func configure(with deal: Deal) {
        
        self.deal = deal
        imageLoadTask = thumbnailView.load(deal.image)
        updateFavorite()
        titleLabel.text = deal.title
        companyLabel.text = deal.company
        cityLabel.text = deal.city
        soldLabel.text = deal.soldLabel
        updatePrices()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCurrencyChanged), name: .currencyChanged, object: nil)
    }
    
    @objc private func handleCurrencyChanged(notification: Notification) {
        updatePrices()
    }
    
    private func updatePrices() {
        guard let deal else {
            return
        }
        
        let currency = Currency.getCurrencyFromSymbol(UserDefaults.currency)
        let fromPriceString = deal.prices.fromPrice?.formattedString(using: currency)
        let priceLabelString = deal.prices.price.formattedString(using: currency)
        
        fromPriceLabel.isHidden = deal.prices.fromPrice == nil
        fromPriceLabel.attributedText = fromPriceLabelAttributedText(fromPriceString)
        priceLabel.attributedText = priceLabelAttributedText(priceLabelString)
    }
    
    private func fromPriceLabelAttributedText(_ text: String?) -> NSAttributedString? {
        guard let text else {
            return nil
        }
        
        return NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.secondaryDealLabelColor ?? .systemGray
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
    }
    
    @objc func favoriteTapped() {
        guard let deal else { return }
        var favorites = UserDefaults.favorites
        
        if favorites.contains(where: { $0 == deal.unique }) {
            favorites.removeAll(where: { $0 == deal.unique })
        } else {
            favorites.append(deal.unique)
        }
        
        UserDefaults.favorites = favorites
        updateFavorite()
    }
    
    private func updateFavorite() {
        let favorites = UserDefaults.favorites
        guard let deal else { return }
        let image = favorites.contains(where:  { $0 == deal.unique }) ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: image), for: .normal)
    }
}
