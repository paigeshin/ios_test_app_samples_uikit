//
//  Account.swift
//  WritingFirstTest
//
//  Created by paige shin on 2022/07/13.
//

import Foundation

enum AccountError: Error {
    case insufficientFunds
}

struct Account {
    
    var balance: Double = 0.0
    
    mutating func deposit(_ amount: Double) {
        self.balance += amount
    }
    
    mutating func withdraw(_ amount: Double) throws {
        let netBalance: Double = self.balance - amount
        if netBalance < 0 {
            throw AccountError.insufficientFunds
        } else {
            self.balance = netBalance
        }
    }
    
}
