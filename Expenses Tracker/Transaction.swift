//
//  Transaction.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 22.04.2023.
//

import Foundation

struct TransactionsResponse: Decodable {
    let transactions: [Transaction]
}

struct Transaction: Decodable {
    let id: Int
    let type: String
    let date: Date
    let seller: String
    let category: String
    let amount: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "transactionType"
        case date = "transactionDate"
        case seller = "seller"
        case category = "category"
        case amount = "amount"
        case description = "notes"
    }
}
