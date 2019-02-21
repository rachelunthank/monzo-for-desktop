//
//  CollectionViewHeaderView.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 31/01/2019.
//  Copyright © 2019 rachelunthank. All rights reserved.
//

import Cocoa

class CollectionViewHeaderView: NSView {

    @IBOutlet var headerLabel: NSTextField!

    override func prepareForReuse() {
        headerLabel.stringValue = ""
    }
}
