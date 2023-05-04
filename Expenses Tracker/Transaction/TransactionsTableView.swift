//
//  TransactionsTableView.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 22.04.2023.
//

import UIKit

class TransactionsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var didSelectItemHandler: ((Int) -> Void)?
    var rowsToReturn: Int?
    
    let transactionFetcher = Transactions()
    var transactionList: [Transaction] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        

        self.delegate = self
        self.dataSource = self
        self.rowHeight = 50
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.isScrollEnabled = false
        self.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.transactionIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.loadTransactions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let transactionCell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.transactionIdentifier, for: indexPath) as? TransactionViewCell {
            
            let transaction = transactionList[indexPath.row]
            transactionCell.cellTypeLabel.text = "\(transaction.type.capitalized)"
            transactionCell.cellAmountLabel.text = "\(transactionCell.formatCurrency(transaction.amount, "EUR"))"
            transactionCell.cellTitleLabel.text = "\(transaction.title)"
            
            let sign: String
            if (transaction.type == "income") {
                transactionCell.cellAmountLabel.textColor = UIColor(red: 0, green: 0.55, blue: 0, alpha: 1.0)
                sign = "+"
            } else {
                transactionCell.cellAmountLabel.textColor = UIColor(red: 0.67, green: 0, blue: 0, alpha: 1.0)
                sign = "-"
            }
            transactionCell.cellAmountLabel.text = sign + " " + transactionCell.formatCurrency(transaction.amount, "EUR")

            
            #if DEBUG
                transactionCell.self.layer.borderWidth = 2
                transactionCell.self.layer.borderColor = UIColor.red.cgColor
            #endif
            transactionCell.layer.cornerRadius = 20
            transactionCell.clipsToBounds = true
            
            return transactionCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(rowsToReturn ?? 0, transactionList.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        didSelectItemHandler?(selectedRow)
    }
    
    func loadTransactions() {
        transactionFetcher.fetchTransactions(queryParams: "") { result in
            do {
                switch result {
                case .success(let data):
                    let response = try JSONDecoder().decode([Transaction].self, from: data)
                    self.transactionList = response
                case .failure(let error):
                    throw error
                }
            } catch {
                print("Error on fetching: \(error)")
            }
            
        }
    }
}
