//
//  DealsViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import UIKit

class DealsViewController: UITableViewController {
    private let viewModel: DealsViewModel
        
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
    
    private(set) var selectedDealCell: DealTableViewCell?
        
    init(viewModel: DealsViewModel = DealsViewModel()) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DealsViewModel()
        super.init(style: .insetGrouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.showOnlyFavorites ? "Favorieten" : "Deals"

        tableView.backgroundColor = .systemBackground
        tableView.register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.directionalLayoutMargins = .init(top: .zero, leading: 12, bottom: .zero, trailing: 12)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
                
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        fetchDeals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
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
                self?.tableView.reloadData()
            }
        }
    }
    
    public func refilterDeals() {
        viewModel.filterDeals()
        tableView.reloadData()
    }
}

extension DealsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.deals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DealTableViewCell.reuseIdentifier, for: indexPath) as! DealTableViewCell
        cell.configure(with: viewModel.deals[indexPath.section])
        cell.events.onFavoriteChanged = { [weak self] in
            if self?.viewModel.showOnlyFavorites ?? false {
                self?.refilterDeals()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deal = viewModel.deals[indexPath.section]
        
        selectedDealCell = tableView.cellForRow(at: indexPath) as? DealTableViewCell
        
        let dealVC = DealViewController(initialDeal: deal)
        navigationController?.pushViewController(dealVC, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 2 {
            if viewModel.loadMoreItems() {
                print("Loading more")
                tableView.reloadData()
            }
        }
    }
}
