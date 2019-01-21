//
//  AccountManager.swift
//  monzofordesktop
//
//  Created by Rachel Unthank on 03/11/2018.
//  Copyright © 2018 rachelunthank. All rights reserved.
//

import Foundation

public class AccountManager {

    private let accessToken = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJlYiI6IlNEZ21LcFVKVVQ1OE5uOXFtbndUIiwianRpIjoiYWNjdG9rXzAwMDA5ZW40WWxCNmdzd085T1FlaWYiLCJ0eXAiOiJhdCIsInYiOiI1In0.T8i9OKA2is5z0p_ygRT2k0qoK_fXIQzfrxrX_29lMK2ywGznn6ZJvJlkU_FheOXlYhQPQLacA-6_G2fX0siW_Q"

    public var accountId = "acc_00009QaQi8HDCkEhybebL7"

    private let apiUrlString = "https://api.monzo.com/"

    public func getAccountBalance(completion: @escaping ((_ balance: Balance)->Void)) {
        let balanceUrlString = apiUrlString + "balance"
        let fullUrlString = balanceUrlString + "?account_id=\(accountId)"
        guard let balanceUrl = URL(string: fullUrlString) else { return }
        let balanceRequest = getRequestForUrl(balanceUrl)

        URLSession.shared.dataTask(with: balanceRequest) { (data, response, error) in
            guard let data = data else { return }
            guard let balance = try? JSONDecoder().decode(Balance.self, from: data) else { return }
            completion(balance)
        }.resume()
    }

    public func getTransactions(completion: @escaping ((_ transactions: AccountTransactions)->Void)) {
        let transactionsUrlString = apiUrlString + "transactions"
        let fullUrlString = transactionsUrlString + "?expand[]=merchant&account_id=\(accountId)"
        let sinceDateUrlString = fullUrlString + "&since=2018-10-01T00:00:00Z"
        guard let transactionUrl = URL(string: sinceDateUrlString) else { return }
        let transactionsRequest = getRequestForUrl(transactionUrl)

        URLSession.shared.dataTask(with: transactionsRequest) { (data, response, error) in
            guard let data = data else { return }
            guard let transactions = try? JSONDecoder().decode(AccountTransactions.self, from: data) else { return }
            completion(transactions)
        }.resume()
    }

    public func getPots(completion:@escaping ((_ transactions: AccountPots)->Void)) {
        let potsUrlString = apiUrlString + "pots"
        guard let potsUrl = URL(string: potsUrlString) else { return }
        let potsRequest = getRequestForUrl(potsUrl)

        URLSession.shared.dataTask(with: potsRequest) { (data, response, error) in
            guard let data = data else { return }
            guard let pots = try? JSONDecoder().decode(AccountPots.self, from: data) else { return }
            completion(pots)
        }.resume()
    }

    public func getAccounts(completion:@escaping ((_ transactions: Accounts)->Void)) {
        let accountsUrlString = apiUrlString + "accounts"
        guard let accountsUrl = URL(string: accountsUrlString) else { return }
        let accountsRequest = getRequestForUrl(accountsUrl)

        URLSession.shared.dataTask(with: accountsRequest) { (data, response, error) in
            guard let data = data else { return }
            guard let accounts = try? JSONDecoder().decode(Accounts.self, from: data) else { return }
            completion(accounts)
            }.resume()
    }
}

extension AccountManager {

    private func getRequestForUrl(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "authorization")
        return request
    }
}
