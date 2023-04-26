//
//  InvoiceAddController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 16.04.2023.
//

import UIKit
// TODO: de conectat la API, de facut POST cu JSON-ul intreg

class InvoiceAddController: UIViewController, UITextFieldDelegate {
    let typeSwitch = TransactionTypeSwitch()
    
    let amount = UITextField()
    let amountDecimal = UITextField()
    
    let titleLabel = UILabel()
    let transactionTitle = UITextField()

    let date = UIDatePicker()
    
    let detailsLabel = UILabel()
    let category = UITextField()
    let trader = UITextField()
    
    let descriptionLabel = UILabel()
    let transactionDescription = UITextView()
    
    let submitButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New"
        self.navigationItem.title = "New Invoice"
        
        setupTypeSwitch()
        setupUI()
        setupNavButtons()
    }
    
    private func setupTypeSwitch() {
        view.addSubview(typeSwitch)
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            typeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            typeSwitch.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            typeSwitch.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupUI() {
        addGeneralConstraints(for: amount, to: typeSwitch, widthConstant: -100)
        styleFields(amount, "Enter amount here")
        amount.keyboardType = .numberPad
        
        view.addSubview(amountDecimal)
        amountDecimal.translatesAutoresizingMaskIntoConstraints = false
        styleFields(amountDecimal, ".00")
        amountDecimal.keyboardType = .numberPad
        NSLayoutConstraint.activate([
            amountDecimal.topAnchor.constraint(equalTo: amount.topAnchor),
            amountDecimal.leftAnchor.constraint(equalTo: amount.rightAnchor, constant: 10),
            amountDecimal.heightAnchor.constraint(equalTo: amount.heightAnchor),
            amountDecimal.rightAnchor.constraint(equalTo: typeSwitch.rightAnchor)
        ])
        
        addGeneralConstraints(for: titleLabel, to: amount)
        styleLabels(titleLabel, "Title & Date:")
        
        addGeneralConstraints(for: transactionTitle, to: titleLabel, topConstant: -10)
        styleFields(transactionTitle, "Enter title here:")
        
        addGeneralConstraints(for: date, to: transactionTitle, topConstant: -3)
        date.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        date.contentHorizontalAlignment = .center
        
        addGeneralConstraints(for: detailsLabel, to: date)
        styleLabels(detailsLabel, "More details:")
        
        addGeneralConstraints(for: category, to: detailsLabel, topConstant: -10)
        styleFields(category, "Invoice Category:")
        
        addGeneralConstraints(for: trader, to: category)
        styleFields(trader, "Trader:")
        
        addGeneralConstraints(for: descriptionLabel, to: trader)
        styleLabels(descriptionLabel, "Description:")
        
        addGeneralConstraints(for: transactionDescription, to: descriptionLabel, topConstant: -10, heightAdd: 50)
        transactionDescription.isEditable = true
        transactionDescription.font = UIFont.systemFont(ofSize: 16.0)
        transactionDescription.layer.borderWidth = 1
        transactionDescription.layer.cornerRadius = 5
        transactionDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        addGeneralConstraints(for: submitButton, to: transactionDescription, topConstant: 40)
        submitButton.setTitle("Submit Invoice", for: .normal)
        submitButton.backgroundColor = .quaternaryLabel
        submitButton.setTitleColor(.label, for: .normal)
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.lightGray.cgColor
        submitButton.layer.cornerRadius = 5
    }
    
    private func styleFields(_ field: UITextField, _ text: String) {
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: field.frame.height))
        
        field.leftView = padding
        field.rightView = padding
        field.leftViewMode = .always
        field.rightViewMode = .always
        
        field.placeholder = text
        field.layer.cornerRadius = 10
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 1
        field.delegate = self
    }
    
    private func styleLabels(_ label: UILabel, _ text: String) {
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.text = text
    }
    
    private func addGeneralConstraints(for subview: UIView, to superview: UIView, additionalConstraints: [NSLayoutConstraint] = [], widthConstant: CGFloat = 0, topConstant: CGFloat = 10, heightAdd: CGFloat = 0) {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: topConstant),
            subview.leftAnchor.constraint(equalTo: superview.leftAnchor),
            subview.widthAnchor.constraint(equalTo: typeSwitch.widthAnchor, constant: widthConstant),
            subview.heightAnchor.constraint(equalToConstant: 50 + heightAdd)
        ])
        NSLayoutConstraint.activate(additionalConstraints)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == amount) {
            return changeCharactersIn(textField, range, replacementString: string, 8, CharacterSet.decimalDigits)
        }
        if (textField == amountDecimal) {
            return changeCharactersIn(textField, range, replacementString: string, 2, CharacterSet.decimalDigits)
        }
        return changeCharactersIn(textField, range, replacementString: string, 32, CharacterSet.alphanumerics)
    }
    
    private func changeCharactersIn(_ textField: UITextField, _ range: NSRange, replacementString string: String, _ limit: Int, _ allowedCharacters: CharacterSet) -> Bool {
        if let currentString: NSString = textField.text as NSString? {
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let characterSet = CharacterSet(charactersIn: string)
            return newString.length <= limit && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    private func setupNavButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset Invoice",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(InvoiceAddController.leftBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Use Template", style: .done, target: self, action: #selector(InvoiceAddController.rightBarButtonItemTapped))
    }
    
    @objc func leftBarButtonItemTapped() {
        let alertController = UIAlertController(title: "Are you sure you want to reset the invoice?",
                                                message: "This action cannot be undone, everything inserted into the fields will be reset and lost forever.",
                                                preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            //self.resetFields()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        alertController.preferredAction = yesAction
        present(alertController, animated: true)
    }
    
    @objc func rightBarButtonItemTapped() {
        // TODO: de implementat sistemul care foloseste un sablon
    }
    
    private func resetFields() {
        // TODO: de implementat sistemul care curata toate campurile
    }
}


