//
//  Account.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 18/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Foundation

public struct Accounts: Decodable {
    let accounts: [Account]
}

struct Account: Decodable {
    let id: String
    let closed: Bool
    let created: String
    let description: String
    let type: AccountType
    let owners: [Owner]
    let accountNumber: String?
    let sortCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case closed
        case created
        case description
        case type
        case owners
        case accountNumber = "account_number"
        case sortCode = "sort_code"
    }
}

struct Owner: Decodable {
    let userID: String
    let preferredName: String
    let preferredFirstName: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case preferredName = "preferred_name"
        case preferredFirstName = "preferred_first_name"
    }
}

enum AccountType: String, Decodable {

    case prepaid = "Prepaid Acount"
    case current = "Current Account"
    case joint = "Joint Current Account"
    case other = "Unknown"

    init(from decoder: Decoder) throws {
        let type = try decoder.singleValueContainer().decode(String.self)
        switch type {
        case "uk_prepaid": self = .prepaid
        case "uk_retail": self = .current
        case "uk_retail_joint": self = .joint
        default: self = .other
        }
    }
}
