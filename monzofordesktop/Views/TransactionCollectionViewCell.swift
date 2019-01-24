//
//  TransactionCollectionViewCell.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 12/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Cocoa

class TransactionCollectionViewCell: NSCollectionViewItem {
    
    @IBOutlet var merchantImageView: NSImageView!
    @IBOutlet var merchantLabel: NSTextField!
    @IBOutlet var transactionAmount: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
        view.layer?.cornerRadius = 5.0
        view.layer?.masksToBounds = true

        merchantImageView?.wantsLayer = true
        merchantImageView?.layer?.cornerRadius = 5.0
        merchantImageView?.layer?.masksToBounds = true
    }

    override func prepareForReuse() {
        merchantImageView.image = nil
        merchantLabel.stringValue = ""
        transactionAmount.stringValue = ""
        transactionAmount.textColor = .labelColor
    }
}
