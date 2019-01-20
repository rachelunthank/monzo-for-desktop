//
//  Balance.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 03/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Foundation

public struct Balance: Decodable {

    let balance: Int
    let totalBalance: Int
    let balanceIncludingFlexibleSavings: Int
    let currency: String
    let spendToday: Int
    let localCurrency: String
    let localExchangeRate: Int
    let localSpend: [LocalSpend]

    enum CodingKeys: String, CodingKey {
        case balance
        case totalBalance = "total_balance"
        case balanceIncludingFlexibleSavings = "balance_including_flexible_savings"
        case currency
        case spendToday = "spend_today"
        case localCurrency = "local_currency"
        case localExchangeRate = "local_exchange_rate"
        case localSpend = "local_spend"
    }
}

struct LocalSpend: Decodable {
    let spendToday: Int
    let currency: String

    enum CodingKeys: String, CodingKey {
        case spendToday = "spend_today"
        case currency
    }
}
