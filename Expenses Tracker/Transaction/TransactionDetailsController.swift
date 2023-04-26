//
//  TransactionDetailsController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 21.04.2023.
//

import UIKit
// TODO: de implementat cu API-ul
class TransactionDetailsController: UIViewController {
    var transactionId: Int = 123
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction #\(transactionId)"
        view.backgroundColor = .systemBackground
        
        let transactionDate = UILabel()
        view.addSubview(transactionDate)
        transactionDate.translatesAutoresizingMaskIntoConstraints = false
        transactionDate.text = "12/03/2022 19:05:44"
        NSLayoutConstraint.activate([
            transactionDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -13),
            transactionDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22.0)
        ])
        
        let transactionType = UILabel()
        styleLabel(transactionType, "Expense", 42.0)
        addConstraints(for: transactionType, to: transactionDate, bottomConstant: 25.0, leftConstant: -10.0)
        
        let transactionAmount = UILabel()
        styleLabel(transactionAmount, "- €12,345,678.90", 34.0)
        addConstraints(for: transactionAmount, to: transactionType)
        
        let detailsLabel = UILabel()
        styleLabel(detailsLabel, "Details:", 20.0)
        addConstraints(for: detailsLabel, to: transactionAmount, bottomConstant: 40.0)
        
        let transactionTitle = UILabel()
        styleLabel(transactionTitle, "Title: Cumparaturi Mega", 18.0)
        addConstraints(for: transactionTitle, to: detailsLabel)
        
        let transactionCategory = UILabel()
        styleLabel(transactionCategory, "Category: Food", 16.0)
        addConstraints(for: transactionCategory, to: transactionTitle)
        
        let transactionTrader = UILabel()
        styleLabel(transactionTrader, "Trader: Mega Image S.R.L.", 16.0)
        addConstraints(for: transactionTrader, to: transactionCategory)
        
        let transactionDescription = UILabel()
        styleLabel(transactionDescription, "\nDescription:\nBuy eggs, milk, other diary products. Purchased a Milka chocolate and three Twix, one white bread.", 16.0)
        addConstraints(for: transactionDescription, to: transactionTrader)
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
}
