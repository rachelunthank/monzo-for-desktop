//
//  Formatter+Extensions.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 21/01/2019.
//  Copyright © 2019 rachelunthank. All rights reserved.
//

import Foundation

// Date formatter to get date string for URLs
extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
