//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Gregory Keeley on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func testZipcodeToCoordinates() {
      // arrange
      let zipcode = "10023"
      
      let exp = XCTestExpectation(description: "zipcode parsed")
      
      // act
      ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
        switch result {
        case .failure(let fetchingError):
          XCTFail("coordinates fetching error: \(fetchingError)")
        case .success(let coordinate):
          // assert
          XCTAssertEqual(coordinate.lat, 40.7754123)
          exp.fulfill()
        }
      }
      
      wait(for: [exp], timeout: 3.0)
    }
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
