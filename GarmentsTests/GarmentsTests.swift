//
//  GarmentsTests.swift
//  GarmentsTests
//
//  Created by Arshdeep on 2022-08-25.
// 

import XCTest
@testable import Garments

class GarmentsTests: XCTestCase {
    var databaseAccess: DatabaseAccess? = nil
    
    override func setUp() {
        super.setUp()
        
        CONFIG.SELECTED = .TEST
        databaseAccess = DatabaseAccess()
        
        //For testing multiple test cases, CoreDataStack must not have a single instance.
        databaseAccess?.coreDataStack = CoreDataStack()
    }
    
    override func tearDown() {
        super.tearDown()

        databaseAccess = nil
    }
    
    func testCreatesDatabaseAccessObject() {
        XCTAssertNotNil(databaseAccess)
    }
    
    func testSaveProduct() {
        let expectation = expectation(description: "SaveProduct")
        
        databaseAccess?.saveProduct(name: "Test Garment 1") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchAllProducts() {
        databaseAccess?.saveProduct(name: "Shorts", completion: nil)
        databaseAccess?.saveProduct(name: "Hat", completion: nil)
        databaseAccess?.saveProduct(name: "Top", completion: nil)

        let products = databaseAccess?.fetchAllProducts()?.count
        
        XCTAssertEqual(products, 3)
    }
    
    func testSortProductsByName() {//Sort Alphabetically
        databaseAccess?.saveProduct(name: "Shirt", completion: nil)
        databaseAccess?.saveProduct(name: "Dress", completion: nil)
        databaseAccess?.saveProduct(name: "Tunic", completion: nil)
        
        let products = databaseAccess?.fetchAllProducts(productSortingKey: SortBy.name)

        XCTAssertEqual(products?.first?.name, "Dress")
        XCTAssertEqual(products?[1].name, "Shirt")
        XCTAssertEqual(products?.last?.name, "Tunic")
    }
    
    func testSortProductsByCreationDate() {//Sort Latest Added on Top
        databaseAccess?.saveProduct(name: "Pajama", completion: nil)
        databaseAccess?.saveProduct(name: "T-Shirt", completion: nil)
        databaseAccess?.saveProduct(name: "Cap", completion: nil)
        
        let products = databaseAccess?.fetchAllProducts(productSortingKey: SortBy.creationDate)

        XCTAssertEqual(products?.first?.name, "Cap")
        XCTAssertEqual(products?[1].name, "T-Shirt")
        XCTAssertEqual(products?.last?.name, "Pajama")
    }
}
