//
//  Transaction.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 22.04.2023.
//

import Foundation

struct Transaction: Decodable {
    let id: Int
    let date: String
    let type: String
    let title: String
    let category: String
    let trader: String
    let amount: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, date, type, title, category, trader, amount, description
    }

}
