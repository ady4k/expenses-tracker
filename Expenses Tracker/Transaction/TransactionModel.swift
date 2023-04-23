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
    let date: Date
    let type: String
    let title: String
    let category: String
    let trader: String
    let amount: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case type = "type"
        case title = "title"
        case category = "category"
        case trader = "trader"
        case amount = "amount"
        case description = "description"
    }
}
