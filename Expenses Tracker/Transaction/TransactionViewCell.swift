//
//  TransactionViewCell.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 16.04.2023.
//

import UIKit

// TODO: de folosit datele dinamice pentru fiecare tranzactie
// TODO: refactorizare, refolosire cod constraints, eventual stilizare pentru UILabel()
class TransactionViewCell: UITableViewCell {
    static let transactionIdentifier = "identifier"
    var isNegative: Bool = true
    var cashAmount: Double = 12345678.90
    var currencyCode: String = "EUR"
    
    let cellTitleLabel = UILabel()
    let cellTypeLabel = UILabel()
    let cellAmountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellTitle()
        setupCellType()
        setupCellAmount(isNegative, cashAmount)
    
        #if DEBUG
            setupDevBorders()
        #endif
    }
    
    func setupCellTitle() {
        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cellTitleLabel.text = "Transaction Title"
        
        NSLayoutConstraint.activate([
            cellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            cellTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            cellTitleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func setupCellType() {
        contentView.addSubview(cellTypeLabel)
        cellTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTypeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cellTypeLabel.text = "Expense"
        
        NSLayoutConstraint.activate([
            cellTypeLabel.leadingAnchor.constraint(equalTo: cellTitleLabel.trailingAnchor, constant: 5.0),
            cellTypeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            cellTypeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func setupCellAmount(_ negativeAmount: Bool, _ amount: Double) {
        contentView.addSubview(cellAmountLabel)
        cellAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        cellAmountLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cellAmountLabel.textAlignment = .right
        
        let sign: String
        if (negativeAmount == false) {
            cellAmountLabel.textColor = UIColor(red: 0, green: 0.55, blue: 0, alpha: 1.0)
            sign = "+"
        } else {
            cellAmountLabel.textColor = UIColor(red: 0.67, green: 0, blue: 0, alpha: 1.0)
            sign = "-"
        }
        cellAmountLabel.text = sign + " " + formatCurrency(amount, currencyCode)
        
        NSLayoutConstraint.activate([
            cellAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            cellAmountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            cellAmountLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func formatCurrency(_ amount: Double, _ currencyCode: String) -> String {
        return amount.formatted(.currency(code: currencyCode))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // TODO: deinit
    }
    
    
    func setupDevBorders() {
        cellAmountLabel.layer.borderWidth = 2
        cellAmountLabel.layer.borderColor = UIColor.black.cgColor
        
        cellTypeLabel.layer.borderWidth = 2
        cellTypeLabel.layer.borderColor = UIColor.blue.cgColor
        
        cellTitleLabel.layer.borderWidth = 2
        cellTitleLabel.layer.borderColor = UIColor.green.cgColor
    }
}
