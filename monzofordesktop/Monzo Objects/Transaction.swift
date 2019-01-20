//
//  Transaction.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 03/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Foundation

public struct AccountTransactions: Decodable {
    let transactions: [Transaction]
}

struct Transaction: Decodable {
    let id: String
    let created: String
    let description: String
    let amount: Int
    let fees: Fees
    let currency: String
    let merchant: Merchant?
    let notes: String
    let metadata: [String: String]
    let labels: String?
    let accountBalance: Int
    let attachments: [Attachments?]
    let international: Bool?
    let category: TransactionCategory
    let isLoad: Bool
    let settled: String
    let localAmount: Int
    let localCurrency: String
    let updated: String
    let accountID: String
    let userID: String
    let counterparty: Counterparty
    let scheme: String
    let dedupeID: String
    let originator: Bool
    let includeInSpending: Bool
    let canBeExcludedFromBreakdown: Bool
    let canBeMadeSubscription: Bool
    let canSplitTheBill: Bool
    let canAddToTab: Bool

    enum CodingKeys: String, CodingKey {
        case id, created, description, amount, fees, currency, merchant, notes, metadata, labels
        case accountBalance = "account_balance"
        case attachments, international, category
        case isLoad = "is_load"
        case settled
        case localAmount = "local_amount"
        case localCurrency = "local_currency"
        case updated
        case accountID = "account_id"
        case userID = "user_id"
        case counterparty, scheme
        case dedupeID = "dedupe_id"
        case originator
        case includeInSpending = "include_in_spending"
        case canBeExcludedFromBreakdown = "can_be_excluded_from_breakdown"
        case canBeMadeSubscription = "can_be_made_subscription"
        case canSplitTheBill = "can_split_the_bill"
        case canAddToTab = "can_add_to_tab"
    }
}

struct Counterparty: Decodable {
    let accountNumber: String?
    let name: String?
    let sortCode: String?
    let userId: String?

    enum CodingKeys: String, CodingKey {
        case accountNumber = "account_number"
        case name
        case sortCode = "sort_code"
        case userId = "user_id"
    }
}


struct Merchant: Decodable {
    let id: String
    let groupID: String
    let created: String
    let name: String
    let logo: String
    let emoji: String
    let category: String
    let online: Bool
    let atm: Bool
    let address: Address
    let updated: String
    let metadata: [String: String]
    let disableFeedback: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case groupID = "group_id"
        case created
        case name
        case logo
        case emoji
        case category
        case online
        case atm
        case address
        case updated
        case metadata
        case disableFeedback = "disable_feedback"
    }
}

struct Address: Decodable {
    let shortFormatted: String
    let formatted: String
    let address: String
    let city: String
    let region: String
    let country: String
    let postcode: String
    let latitude: Double
    let longitude: Double
    let zoomLevel: Int
    let approximate: Bool

    enum CodingKeys: String, CodingKey {
        case shortFormatted = "short_formatted"
        case formatted
        case address
        case city
        case region
        case country
        case postcode
        case latitude
        case longitude
        case zoomLevel = "zoom_level"
        case approximate
    }
}

struct Fees: Decodable {
}

struct Attachments: Decodable {
}

enum TransactionCategory: String, Decodable {

    case entertainment = "Entertainment"
    case groceries = "Groceries"
    case eatingOut = "Eating Out"
    case general = "General"
    case shopping = "Shopping"
    case transport = "Transport"
    case finances = "Finances"
    case bills = "Bills"
    case holidays = "Holidays"
    case expenses = "Expenses"
    case family = "Family"
    case personalCare = "Personal Care"
    case other = "Other"


    init(from decoder: Decoder) throws {
        let type = try decoder.singleValueContainer().decode(String.self)
        switch type {
        case "entertainment": self = .entertainment
        case "groceries": self = .groceries
        case "eating_out": self = .eatingOut
        case "general": self = .general
        case "shopping": self = .shopping
        case "transport": self = .transport
        case "cash": self = .finances
        case "bills": self = .bills
        case "holidays": self = .holidays
        case "expenses": self = .expenses
        case "family": self = .family
        case "personal_care": self = .personalCare
        default: self = .other
        }
    }
}
