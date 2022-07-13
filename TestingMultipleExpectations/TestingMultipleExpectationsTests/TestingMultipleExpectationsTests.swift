//
//  TestingMultipleExpectationsTests.swift
//  TestingMultipleExpectationsTests
//
//  Created by Mohammad Azam on 5/8/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
@testable import TestingMultipleExpectations

class when_posting_two_alerts_using_alert_manager: XCTestCase {

    func test_generates_two_notifications() {
        
        let alertManager = AlertManager()
        
        let exp = expectation(forNotification: Notification.Name.alertNotification, object: alertManager, handler: nil)
        
        exp.expectedFulfillmentCount = 2
        
        alertManager.postAlert()
        alertManager.postAlert()
        
        wait(for: [exp], timeout: 2.0)
        
    }

}
