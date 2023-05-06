//
//  SettingsController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 16.04.2023.
//

import UIKit
let userDefaults = UserDefaults.standard
let numberOfTransactions = userDefaults.integer(forKey: Constants.numberOfTransactionsOnMainViewDefaultsKey)

class SettingsController: UIViewController, UITextFieldDelegate {
    let transNumberLabel = UILabel()
    let transNumberInput = UITextField()
    var transNumber: Int = numberOfTransactions
    
    let authorizeWithFaceIdLabel = UILabel()
    let authorizeWithFaceIdSwitch = UISwitch()
    
    let dropdownDefaultLabel = UILabel()
    let dropdownDefaultSwitch = UISwitch()
    
    let enableTrendsLabel = UILabel()
    let enableTrendsSwitch = UISwitch()
    
    let resetDatabaseButton = UIButton()
    let applySettingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupElements()
        setupNavButton()
    }
    
    private func setupElements() {
        styleLabel(transNumberLabel, "Home Transactions Number:")
        view.addSubview(transNumberLabel)
        transNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            transNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
        ])
        
        transNumberInput.text = String(transNumber)
        transNumberInput.borderStyle = .bezel
        // TODO: - change to the custom TextField when implemented
        transNumberInput.delegate = self
        addConstraints(for: transNumberInput, to: transNumberLabel, isSideButton: true)
        
        styleLabel(authorizeWithFaceIdLabel, "FaceID Authorization:")
        addConstraints(for: authorizeWithFaceIdLabel, to: transNumberLabel)
        addConstraints(for: authorizeWithFaceIdSwitch, to: authorizeWithFaceIdLabel, isSideButton: true)
        
        styleLabel(enableTrendsLabel, "Trends Section Enabled:")
        addConstraints(for: enableTrendsLabel, to: authorizeWithFaceIdLabel)
        addConstraints(for: enableTrendsSwitch, to: enableTrendsLabel, isSideButton: true)
        
        styleLabel(dropdownDefaultLabel, "Home Dropdown Enabled:")
        addConstraints(for: dropdownDefaultLabel, to: enableTrendsLabel)
        addConstraints(for: dropdownDefaultSwitch, to: dropdownDefaultLabel, isSideButton: true)
        
        resetDatabaseButton.setTitle("Reset Database", for: .normal)
        resetDatabaseButton.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.75)
        resetDatabaseButton.setTitleColor(UIColor.label, for: .normal)
        resetDatabaseButton.layer.cornerRadius = 10
        resetDatabaseButton.layer.borderWidth = 1
        resetDatabaseButton.layer.borderColor = UIColor.lightGray.cgColor
        addConstraints(for: resetDatabaseButton, to: dropdownDefaultLabel, topConstant: 50, additionalConstraints: [
            resetDatabaseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            resetDatabaseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        // TODO: - Add Button confirm and logic for Reset Database
        // - API Request to Delete, to be implemented in backend
        
        applySettingsButton.setTitle("Restore Defaults", for: .normal)
        applySettingsButton.backgroundColor = UIColor.systemMint
        applySettingsButton.setTitleColor(UIColor.label, for: .normal)
        applySettingsButton.layer.cornerRadius = 10
        applySettingsButton.layer.borderWidth = 1
        applySettingsButton.layer.borderColor = UIColor.lightGray.cgColor
        addConstraints(for: applySettingsButton, to: resetDatabaseButton, topConstant: 10, additionalConstraints: [
            applySettingsButton.rightAnchor.constraint(equalTo: resetDatabaseButton.rightAnchor),
            applySettingsButton.heightAnchor.constraint(equalTo: resetDatabaseButton.heightAnchor)
        ])
        // TODO: - Add Button logic for restoring the default changes
        // - Save changes to UserDefaults
        // - Take from a template, stored separately?
        
        // TODO: - Implement Logic for all settings
        // - Last number of transactions, variable in MainMenuController
        // - Toggle FaceID authorization on TransactionHistoryController
        // - Show or hide the trends on MainMenuController
        // - The default setting for the Budget dropdown on MainMenuController
    }
    
    private func styleLabel(_ label: UILabel, _ text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20.0)
    }
    
    private func addConstraints(for subview: UIView, to superview: UIView, isSideButton: Bool = false, topConstant: CGFloat = 10, additionalConstraints: [NSLayoutConstraint] = []) {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        if (isSideButton == false) {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: topConstant),
                subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 0),
                
            ])
        } else {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: superview.topAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 1),
                subview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                subview.widthAnchor.constraint(equalToConstant: 75)
            ])
        }
        NSLayoutConstraint.activate(additionalConstraints)
    }
    
    private func setupNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply Changes",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(SettingsController.rightBarButtonItemTapped))
    }
    
    @objc func rightBarButtonItemTapped() {
        // TODO: - Logic for the button to be implemented
        // - Disabled when no changes are made
        // - Enabled and apply when the changed are made
        userDefaults.set(transNumberInput.text, forKey: Constants.numberOfTransactionsOnMainViewDefaultsKey)
        exit(0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == transNumberInput) {
            return changeCharactersIn(textField, range, replacementString: string, 2, CharacterSet.decimalDigits)
        }
        // Limit to 2 digits, 99 max, for more go to TransactionHistory View Controller
        return true
    }
    
    private func changeCharactersIn(_ textField: UITextField, _ range: NSRange, replacementString string: String, _ limit: Int, _ allowedCharacters: CharacterSet) -> Bool {
        if let currentString: NSString = textField.text as NSString? {
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let characterSet = CharacterSet(charactersIn: string)
            return newString.length <= limit && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
