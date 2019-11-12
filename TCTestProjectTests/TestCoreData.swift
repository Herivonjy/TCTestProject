//
//  TestCoreData.swift
//  TCTestProjectTests
//
//  Created by HERIVONJY Aina on 12/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import XCTest
@testable import TestProject

class TestCoreData: XCTestCase {

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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSaveUser() {
        
        let user = User(name: "TestName",
                        lastname: "TestLastName",
                        address: "TestAddress",
                        postalcode: 100,
                        town: "TestTown",
                        birthday: Date(),
                        profil: UIImage(named: "profile")?.pngData())
        let result = DependancyInjectionCodeData.shared.saveUser(user: user)
        XCTAssert(result, "Save user error")
    }
    
    func testUpdateCars() {
        let carEntity = CarEntity()
        carEntity.make = "TestMake"
        carEntity.model = "TestModel"
        carEntity.equipments = nil
        carEntity.picture = nil
        let car = Car(carEntity: carEntity)
        
        let result = DependancyInjectionCodeData.shared.updateCars(cars: [car])
        XCTAssert(result, "Save car error")
    }
    
}
