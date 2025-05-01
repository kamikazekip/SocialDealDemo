//
//  DealViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 30/04/2025.
//

import Domain
import UIKit
import WebKit

class DealViewController: UIViewController, WKNavigationDelegate {
    private enum Constants {
        static let imageViewAspectRatio: CGFloat = 3/5
    }
    
    private let viewModel: DealViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    let imageView: LazyLoadingImageView = {
        let imageView = LazyLoadingImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let descriptionView: WKWebView = {
        let descriptionView = WKWebView(frame: .zero, configuration: {
            let config = WKWebViewConfiguration()
            let contentController = WKUserContentController()
            
            let css = """
               html { font-size: 40px !important; }
               """
            let js = """
               var style = document.createElement('style');
               style.innerHTML = `\(css)`;
               document.head.appendChild(style);
               """
            let userScript = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            contentController.addUserScript(userScript)
            config.userContentController = contentController
            
            return config
        }())
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.scrollView.isScrollEnabled = false
        return descriptionView
    }()
    private let descriptionActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    var webViewHeightConstraint: NSLayoutConstraint!

    init(initialDeal: Deal) {
        self.viewModel = DealViewModel(initialDeal: initialDeal)
        super.init(nibName: nil, bundle: nil)
        configureWithInitialDeal()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionView)
        
        descriptionView.addSubview(descriptionActivityIndicator)
        descriptionView.navigationDelegate = self
        
        scrollView.constraint(to: view)
        
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .standardPadding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: Constants.imageViewAspectRatio),
            
            descriptionView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            descriptionActivityIndicator.topAnchor.constraint(equalTo: descriptionView.topAnchor),
            descriptionActivityIndicator.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            descriptionActivityIndicator.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor),
            descriptionActivityIndicator.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor),
        ])
        
        webViewHeightConstraint = descriptionView.heightAnchor.constraint(equalToConstant: 50)
        webViewHeightConstraint.isActive = true
    }
    
    public func configureWithInitialDeal()  {
        navigationItem.title = viewModel.initialDeal.title
        
        Task { @MainActor in
            if let imageData = await viewModel.fetchImageFromCache() {
                imageView.setImage(imageData)
            } else {
                imageView.load(viewModel.initialDeal.image)
            }
            
            fetchFullDeal()
        }
    }
    
    private func fetchFullDeal() {
        Task { @MainActor in
            do {
                let fullDeal = try await viewModel.fetchFullDeal()
                descriptionView.loadHTMLString(fullDeal.description ?? "Lege description", baseURL: nil)
                descriptionActivityIndicator.isHidden = true
                
            } catch {
                present(UIAlertController(title: "Kan volledige deal niet ophalen", message: error.localizedDescription, preferredStyle: .alert), animated: true)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] result, error in
            guard let self = self else { return }
            if let height = result as? CGFloat {
                self.webViewHeightConstraint.constant = height
                self.view.layoutIfNeeded()
            }
        }
    }
}
