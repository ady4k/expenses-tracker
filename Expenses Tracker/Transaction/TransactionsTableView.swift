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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: de implementat celulele tabelului bazate pe tranzactii
        // TODO: de implementat ViewController pentru celule
        if let transactionCell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.transactionIdentifier, for: indexPath) as? TransactionViewCell {
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
        return rowsToReturn ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        didSelectItemHandler?(selectedRow)
    }
}
