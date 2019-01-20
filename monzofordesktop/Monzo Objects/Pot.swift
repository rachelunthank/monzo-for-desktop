//
//  Pot.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 13/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Foundation

public struct AccountPots: Decodable {
    let pots: [Pot]?
}

struct Pot: Decodable {
    let id: String
    let name: String
    let style: String
    let balance: Int
    let currency: String
    let type: String
    let minimumBalance: Int
    let maximumBalance: Int
    let assignedPermissions: [AssignedPermission]
    let currentAccountID: String
    let roundUp: Bool
    let created: String
    let updated: String
    let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case style
        case balance
        case currency
        case type
        case minimumBalance = "minimum_balance"
        case maximumBalance = "maximum_balance"
        case assignedPermissions = "assigned_permissions"
        case currentAccountID = "current_account_id"
        case roundUp = "round_up"
        case created
        case updated
        case deleted
    }
}

struct AssignedPermission: Decodable {
    let userID: String
    let permissionType: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case permissionType = "permission_type"
    }
}
