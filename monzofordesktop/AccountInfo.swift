//
//  AccountInfo.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 24/01/2019.
//  Copyright © 2019 rachelunthank. All rights reserved.
//

import Foundation

class AccountInfo {

    public static let accessToken = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJlYiI6Im9BYVdXMTZJTytBN2ovOVNIRmxMIiwianRpIjoiYWNjdG9rXzAwMDA5ZjhicGxTYUd5YTg2SDlZaDciLCJ0eXAiOiJhdCIsInYiOiI1In0.fnTTg8fUmNyEouR-dJm00TmEbu9CUQZ5eDHA00Hd15fBUSj9O-5uMcOQ7QKGOXHCIWYL505Wpr5JKK0WzizW8A"

    public static var accountId = "acc_00009QaQi8HDCkEhybebL7"

    public static func updateAccountId(with id: String) {
        accountId = id
    }
}
