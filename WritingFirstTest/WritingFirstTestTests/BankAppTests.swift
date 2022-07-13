//
//  WritingFirstTestTests.swift
//  WritingFirstTestTests
//
//  Created by paige shin on 2022/07/13.
//

import XCTest
@testable import WritingFirstTest

class BankAppTests: XCTestCase {
    
    private var account: Account!
    
    override func setUp() {
        super.setUp()
        self.account = Account()
    }
    
    func test_InitialBalanceZero() {
        XCTAssertTrue(account.balance == 0, "Balance is not zero!")
    }
    
    func test_DepositFunds() {
        account.deposit(100)
        XCTAssertEqual(100.0, account.balance)
    }
    
    func test_WithdrawFunds() {
        self.account.deposit(100)
        try! self.account.withdraw(50)
        XCTAssertEqual(50, self.account.balance)
    }
    
    func test_WithdrawFromInsufficientFunds() {
        self.account.deposit(100)
        XCTAssertThrowsError(try self.account.withdraw(300)) { error in
            XCTAssertEqual(error as! AccountError, AccountError.insufficientFunds)
        }
        XCTAssertEqual(100, self.account.balance)
    }
    
    override func tearDown() {
        super.tearDown()
        self.account = nil
    }
    
}
