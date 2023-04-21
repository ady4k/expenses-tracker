//
//  TransactionDetailsController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 21.04.2023.
//

import UIKit

class TransactionDetailsController: UIViewController {
    var transactionId: Int = 123
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction #\(transactionId)"
        
        let bgColor = UILabel()
        view.addSubview(bgColor)
        
        bgColor.translatesAutoresizingMaskIntoConstraints = false
        bgColor.backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 0.90)
        bgColor.layer.cornerRadius = 15.0
        bgColor.clipsToBounds = true
        bgColor.layer.borderWidth = 2
        bgColor.layer.borderColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00).cgColor
        
        NSLayoutConstraint.activate([
            bgColor.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgColor.heightAnchor.constraint(equalToConstant: 100),
            bgColor.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            bgColor.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let transactionType = UILabel()
        view.addSubview(transactionType)

        transactionType.translatesAutoresizingMaskIntoConstraints = false
        transactionType.text = "Expense"
        transactionType.font = UIFont.boldSystemFont(ofSize: 42)
        
        NSLayoutConstraint.activate([
            transactionType.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            transactionType.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            transactionType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.0)
            
        ])
        
        let transactionAmount = UILabel()
        view.addSubview(transactionAmount)
        
        transactionAmount.translatesAutoresizingMaskIntoConstraints = false
        transactionAmount.text = "- €12,345,678.90"
        transactionAmount.font = UIFont.boldSystemFont(ofSize: 32)
        
        NSLayoutConstraint.activate([
            transactionAmount.topAnchor.constraint(equalTo: transactionType.bottomAnchor),
            transactionAmount.heightAnchor.constraint(equalTo: transactionType.heightAnchor),
            transactionAmount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.0),
            
        ])
        
        let detailsLabel = UILabel()
        view.addSubview(detailsLabel)
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.text = "Details:"
        detailsLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: transactionAmount.bottomAnchor, constant: 20.0),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0)
        ])
        
        let transactionTitle = UILabel()
        view.addSubview(transactionTitle)
        
        transactionTitle.translatesAutoresizingMaskIntoConstraints = false
        transactionTitle.text = "Title: Cumparaturi Mega Image"
        transactionTitle.font = UIFont.systemFont(ofSize: 16.0)
        transactionTitle.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            transactionTitle.leftAnchor.constraint(equalTo: detailsLabel.leftAnchor, constant: 5.0),
            transactionTitle.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 10.0),
            
        ])
        
    }
}
