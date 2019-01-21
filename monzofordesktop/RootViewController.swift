//
//  RootViewController.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 03/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Cocoa

class RootViewController: NSViewController {

    var accountController: AccountManager
    var accountTransactions: [Transaction]?
    var accountPots: [Pot]?
    var accounts = [Account]()

    let cellId = NSUserInterfaceItemIdentifier(rawValue: "TransactionCollectionViewCell")

    @IBOutlet var spentTodayLabel: NSTextField!
    @IBOutlet var balanceLabel: NSTextField!
    @IBOutlet var refreshButton: NSButton!

    @IBOutlet var transactionsCollectionView: NSCollectionView!
    @IBOutlet var transactionsCollectionViewFlowLayout: NSCollectionViewFlowLayout!

    @IBOutlet var accountSelector: NSPopUpButton! {
        didSet {
            accountSelector.removeAllItems()
            accountSelector.action = #selector(changeAccount)
            accountSelector.target = self

        }
    }

    @IBOutlet var transactionView: NSView! {
        didSet {
            transactionView.isHidden = true
            transactionView.wantsLayer = true
            transactionView.layer?.cornerRadius = 5.0
            transactionView.layer?.masksToBounds = true
            transactionView.layer?.borderWidth = 1.0
            transactionView.layer?.borderColor = NSColor.lightGray.cgColor
        }
    }
    @IBOutlet var transactionLogoImageView: NSImageView! {
        didSet {
            transactionLogoImageView?.wantsLayer = true
            transactionLogoImageView?.layer?.cornerRadius = 5.0
            transactionLogoImageView?.layer?.masksToBounds = true
        }
    }
    @IBOutlet var transactionMerchantLabel: NSTextField!
    @IBOutlet var transactionAmountLabel: NSTextField!
    @IBOutlet var transactionCurrencyLabel: NSTextField!
    @IBOutlet var transactionAddressLabel: NSTextField!
    @IBOutlet var transactionCategoryLabel: NSTextField!
    @IBOutlet var transactionDateLabel: NSTextField!

    @IBOutlet var emptyTransactionView: NSView! {
        didSet {
            emptyTransactionView.isHidden = false
            emptyTransactionView.wantsLayer = true
            emptyTransactionView.layer?.cornerRadius = 5.0
            emptyTransactionView.layer?.masksToBounds = true
        }
    }
    @IBOutlet var emptyTransactionImageView: NSImageView!
    
    public override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.accountController = AccountManager()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        self.accountController = AccountManager()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsCollectionView.dataSource = self
        transactionsCollectionView.delegate = self
        transactionsCollectionView.isSelectable = true
        transactionsCollectionView.register(TransactionCollectionViewCell.self, forItemWithIdentifier: cellId)

        getAccountsInfo()
        setBalanceInfo()
        getPotsInfo()
        setTransactionsInfo()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "Monzo For Mac"
    }

    private func setBalanceInfo() {

        accountController.getAccountBalance { (balance) in

            let balanceString = self.formatCurrencyString(from: balance.balance)
            let spentTodayString = self.formatCurrencyString(from: balance.spendToday)

            DispatchQueue.main.async {
                self.balanceLabel.stringValue = balanceString ?? "£0.00"
                self.spentTodayLabel.stringValue = spentTodayString ?? "£0.00"
            }
        }
    }

    private func setTransactionsInfo() {
        accountController.getTransactions { (transactions) in
            self.accountTransactions = transactions.transactions.reversed()
            DispatchQueue.main.async {
                self.transactionsCollectionView.reloadData()
            }
        }
    }

    private func getPotsInfo() {
        accountController.getPots { (pots) in
            self.accountPots = pots.pots
        }
    }

    private func getAccountsInfo() {

        self.accounts.removeAll()
        accountController.getAccounts { (accounts) in
            for account in accounts.accounts {

                guard account.closed == false else { continue }
                self.accounts.append(account)

                DispatchQueue.main.async {
                    self.accountSelector.addItem(withTitle: account.type.rawValue)
                }
            }
        }

    }

    @IBAction func onRefresh(_ sender: Any) {
        setBalanceInfo()
        getPotsInfo()
        setTransactionsInfo()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension RootViewController: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountTransactions?.count ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {

        return NSSize(width: collectionView.frame.width, height: 100)
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {

        let item = collectionView.makeItem(withIdentifier: cellId, for: indexPath)
        let transaction = accountTransactions?[indexPath.item]
        guard let collectionViewItem = item as? TransactionCollectionViewCell else { return item }

        loadTransactionImage(transaction, for: collectionViewItem.merchantImageView)
        loadTransactionCounterparty(transaction, for: collectionViewItem.merchantLabel)
        loadTransactionAmount(transaction, for: collectionViewItem.transactionAmount)

        return collectionViewItem
    }

    func collectionView(_ collectionView: NSCollectionView, shouldSelectItemsAt indexPaths: Set<IndexPath>) -> Set<IndexPath> {
        return indexPaths
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {

        guard let index = indexPaths.first?.item else { return }
        guard let transaction = accountTransactions?[index] else { return }
        loadTransactionView(with: transaction)
    }

    func loadTransactionView(with transaction: Transaction) {
        resetTransactionViewLabels()
        loadTransactionImage(transaction, for: transactionLogoImageView)
        loadTransactionAmount(transaction, for: transactionAmountLabel)
        loadTransactionCounterparty(transaction, for: transactionMerchantLabel)
        loadTransactionDate(transaction, for: transactionDateLabel)
        loadTransactionAddress(transaction, for: transactionAddressLabel)
        transactionCurrencyLabel.stringValue = transaction.currency
        transactionCategoryLabel.stringValue = transaction.category.rawValue
        emptyTransactionView.isHidden = true
        transactionView.isHidden = false
    }
}

extension RootViewController {

    func resetTransactionViewLabels() {
        transactionLogoImageView.image = nil
        transactionAmountLabel.stringValue = ""
        transactionAmountLabel.textColor = .labelColor
        transactionMerchantLabel.stringValue = ""
        transactionAddressLabel.stringValue = ""
        transactionCurrencyLabel.stringValue = ""
        transactionCategoryLabel.stringValue = ""
        transactionDateLabel.stringValue = ""
    }

    func loadTransactionDate(_ transaction: Transaction?, for label: NSTextField) {
        guard let transactionDate = transaction?.created else { return }
        let formatter = Formatter.iso8601
        guard let date = formatter.date(from: transactionDate) else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d, yyyy"
        label.stringValue = dateFormatter.string(from: date)
    }

    func loadTransactionAddress(_ transaction: Transaction?, for label: NSTextField) {
        if transaction?.merchant?.online == true {
            label.stringValue = "Online transaction"
        } else if let address = transaction?.merchant?.address {
            label.stringValue = address.shortFormatted
        }
    }

    func loadTransactionAmount(_ transaction: Transaction?, for label: NSTextField) {
        label.stringValue = formatCurrencyString(from: transaction?.amount ?? 0) ?? "£0.00"
        if minusBalance(transaction?.amount) == false {
            label.textColor = NSColor(calibratedRed: 0, green: 0.4, blue: 0, alpha: 1.0)
        }
    }

    func loadTransactionCounterparty(_ transaction: Transaction?, for label: NSTextField) {

        if let merchantName = transaction?.merchant?.name {
            label.stringValue = merchantName
        } else if let counterparty = transaction?.counterparty.name {
            label.stringValue = counterparty
        } else if transaction?.scheme == "uk_retail_pot" {
            let potId = transaction?.metadata["pot_id"]
            if let potName = getPotName(from: potId) {
                label.stringValue = "\(potName) Pot"
            }
        }
    }

    func loadTransactionImage(_ transaction: Transaction?, for imageView: NSImageView) {

        let potsImage = NSImage(named: "potsImage")
        let placeholderImage = NSImage(named: "monzoLogo")

        guard let imageUrlString = transaction?.merchant?.logo,
            let imageUrl = URL(string: imageUrlString) else {

                if transaction?.scheme == "uk_retail_pot" {
                    imageView.image = potsImage
                } else {
                    imageView.image = placeholderImage
                }
                return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    imageView.image = NSImage(data: data) ?? placeholderImage
                }
            }
        }
    }

    func getPotName(from potId: String?) -> String? {
        guard let pots = accountPots else { return nil }
        for pot in pots {
            if pot.id == potId { return pot.name }
        }
        return nil
    }

    private func formatCurrencyString(from balance: Int) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let absoluteBalance = abs(balance)
        let balanceDec = Double(absoluteBalance) / 100.0
        let balanceValue = NSNumber(value: balanceDec)
        return currencyFormatter.string(from: balanceValue)
    }

    private func minusBalance(_ balance: Int?) -> Bool {
        guard let balance = balance else { return false }
        if balance > 0 { return false }
        return true
    }

    @objc func changeAccount() {
        let index = accountSelector.indexOfSelectedItem
        let selectedAccount = accounts[index]
        accountController.accountId = selectedAccount.id
        DispatchQueue.main.async {
            self.onRefresh(self)
        }
    }
}
