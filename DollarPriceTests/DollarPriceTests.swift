//
//  DollarPriceTests.swift
//  DollarPriceTests
//
//  Created by Камиль Сулейманов on 08.10.2021.
//

import XCTest
@testable import DollarPrice

class DollarPriceTests: XCTestCase {
    
    var vm: ViewModel!

    override func setUpWithError() throws {
      vm = ViewModel()
    }

    override func tearDownWithError() throws {
       vm = nil
    }

    func testGetDollarPriceFromAPI() throws {
        vm.dollarPrice = String()
        let expectedResult = false
        var validate: Bool?
        let expectation = expectation(description: #function)
        
        vm.getPrice {
            self.vm.getPriceAndSaveIt()
            validate = !self.vm.dollarPrice.isEmpty
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail()
            }
        }
        XCTAssertEqual(expectedResult, validate)
    }
}
