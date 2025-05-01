//
//  SettingsViewController.swift
//  SocialDealDemo
//
//  Created by Erik Brandsma on 27/04/2025.
//

import Domain
import UIKit

extension Notification.Name {
    static let currencyChanged = Notification.Name("CurrencyChanged")
}

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Valuta"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private let currencyTextField: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 3
        textView.layer.borderWidth = 1
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.contentInset = .init(top: 6, left: 6, bottom: 6, right: 6)
        return textView
    }()
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Instellingen"
        
        view.addSubview(currencyLabel)
        view.addSubview(currencyTextField)
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            currencyTextField.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: .standardPadding),
            currencyTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            currencyTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        currencyTextField.delegate = self
        picker.delegate = self
        picker.dataSource = self
        
        if let selectedCurrency = Currency.getCurrencyFromSymbol(UserDefaults.currency) {
            updateTextField(with: selectedCurrency)
            
            guard let index = Currency.options.firstIndex(of: selectedCurrency) else {
                return
            }
            picker.selectRow(index, inComponent: .zero, animated: false)
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onViewTapped)))
        currencyTextField.inputView = picker
    }
    
    @objc func onViewTapped() {
        currencyTextField.resignFirstResponder()
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }
    
    // MARK: - UIPickerViewDataSource and UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Currency.options[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = Currency.options[row]
        UserDefaults.currency = selectedCurrency.symbol
        updateTextField(with: selectedCurrency)
        NotificationCenter.default.post(name: .currencyChanged, object: nil)
    }
    
    private func updateTextField(with currency: Currency) {
        currencyTextField.text = "\(currency.title) - (\(currency.symbol))"
    }
}

