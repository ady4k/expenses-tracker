//
//  TransactionDetailsController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 21.04.2023.
//

import UIKit

class TransactionDetailsController: UIViewController {
    var transaction: Transaction?
    
    let transactionDate = UILabel()
    let transactionType = UILabel()
    let transactionAmount = UILabel()
    let detailsLabel = UILabel()
    let transactionTitle = UILabel()
    let transactionCategory = UILabel()
    let transactionTrader = UILabel()
    let transactionDescription = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction #1234"
        view.backgroundColor = .systemBackground
        
        view.addSubview(transactionDate)
        transactionDate.translatesAutoresizingMaskIntoConstraints = false
        transactionDate.text = "12/03/2022 19:05:44"
        NSLayoutConstraint.activate([
            transactionDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -13),
            transactionDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22.0)
        ])
        
        styleLabel(transactionType, "Expense", 42.0)
        addConstraints(for: transactionType, to: transactionDate, bottomConstant: 25.0, leftConstant: -10.0)
        
        styleLabel(transactionAmount, "- €12,345,678.90", 34.0)
        addConstraints(for: transactionAmount, to: transactionType)
        
        styleLabel(detailsLabel, "Details:", 20.0)
        addConstraints(for: detailsLabel, to: transactionAmount, bottomConstant: 40.0)
        
        styleLabel(transactionTitle, "Title: Cumparaturi Mega", 18.0)
        addConstraints(for: transactionTitle, to: detailsLabel)
        
        styleLabel(transactionCategory, "Category: Food", 16.0)
        addConstraints(for: transactionCategory, to: transactionTitle)
        
        styleLabel(transactionTrader, "Trader: Mega Image S.R.L.", 16.0)
        addConstraints(for: transactionTrader, to: transactionCategory)
        
        styleLabel(transactionDescription, "\nDescription:\nBuy eggs, milk, other diary products. Purchased a Milka chocolate and three Twix, one white bread.", 16.0)
        addConstraints(for: transactionDescription, to: transactionTrader)
        
        if let trans = transaction {
            loadTransactionDetails(trans)
        }
    }
    
    func styleLabel(_ label: UILabel, _ text: String, _ fontSize: CGFloat) {
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.text = text
        #if DEBUG
        label.layer.borderWidth = 2
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.blue.cgColor
        #endif
    }
    
    func addConstraints(for subview: UIView, to superview: UIView, bottomConstant: CGFloat = 0, leftConstant: CGFloat = 0) {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomConstant),
            subview.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: leftConstant),
            subview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    func loadTransactionDetails(_ trans: Transaction) {
        title = "Transaction #\(String(trans.id))"
        transactionDate.text = formatDate(trans.date)
        transactionType.text = "\(trans.type.capitalized)"
        transactionAmount.text = formatCurrency(trans.amount, "EUR")
        transactionTitle.text = "Title: \(trans.title)"
        transactionCategory.text = "Category: \(trans.category)"
        transactionTrader.text = "Trader: \(trans.trader)"
        transactionDescription.text = "\nDescription\n\(trans.description)"
        
        if (trans.type == "income") {
            setTextColor(transactionType, isNegative: false)
            setTextColor(transactionAmount, isNegative: false)
        } else {
            setTextColor(transactionType, isNegative: true)
            setTextColor(transactionAmount, isNegative: true)
        }
    }
    
    func formatDate(_ date: String) -> String {
        let dateToBeFormatted = date + "Z"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateToBeFormatted) else {
            fatalError("Unable to parse date")
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func formatCurrency(_ amount: Double, _ currencyCode: String) -> String {
        return amount.formatted(.currency(code: currencyCode))
    }
    
    func setTextColor(_ label: UILabel, isNegative: Bool) {
        if (isNegative == false) {
            label.textColor = UIColor(red: 0, green: 0.55, blue: 0, alpha: 1.0)
        } else {
            label.textColor = UIColor(red: 0.67, green: 0, blue: 0, alpha: 1.0)
        }
    }
}
