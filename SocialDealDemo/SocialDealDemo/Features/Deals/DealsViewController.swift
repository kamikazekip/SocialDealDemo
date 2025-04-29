//
//  DealsViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import UIKit

class DealsViewController: UIViewController {
    private let viewModel: DealsViewModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DealCollectionCell.self, forCellWithReuseIdentifier: DealCollectionCell.reuseIdentifier)
        return collectionView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
        
    init(viewModel: DealsViewModel = DealsViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
                
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        collectionView.dataSource = self
        
        fetchDeals()
    }
    
    private func fetchDeals() {
        activityIndicator.isHidden = false
        Task { [weak self] in
            await self?.viewModel.fetchDeals()
            
            DispatchQueue.main.async {
                self?.activityIndicator.isHidden = true

                if let error = self?.viewModel.fetchingError {
                    self?.errorLabel.isHidden = false
                    self?.errorLabel.text = "Ophalen van deals mislukte:\n\n'\(error.localizedDescription)'"
                    return
                }
                
                self?.errorLabel.isHidden = true
                self?.collectionView.reloadData()
            }
        }
    }
}

extension DealsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.deals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealCollectionCell.reuseIdentifier, for: indexPath) as! DealCollectionCell
        let model = viewModel.deals[indexPath.section]
        cell.configure(with: model)
        return cell
    }
}
