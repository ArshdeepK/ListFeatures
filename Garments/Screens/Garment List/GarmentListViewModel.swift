//
//  GarmentListViewModel.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import Foundation
import UIKit

class GarmentListViewModel {
    
    let databaseAccess: DatabaseAccess
    
    init(databaseAccess: DatabaseAccess, completion: @escaping () -> Void) {
        self.databaseAccess = databaseAccess
        self.databaseAccess.setup(completion: completion)
    }

    // MARK: - Variables

    var reloadTableViewClosure: (()->())?
    var products:[Product]? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // MARK: - Fetch Products
    
    func fetchProducts(sortBy:SortBy = SortBy.name) {
        products = databaseAccess.fetchAllProducts(productSortingKey:sortBy)
    }
    
    // MARK: - Sort Products

    func sortProductsBy(segment:Int) {
        switch segment {
        case 0:
            fetchProducts(sortBy: .name)
        default :
            fetchProducts(sortBy: .creationDate)
        }
    }
    
    // MARK: - Number of Rows

    func numberOfRows() -> Int {
        // Row Count is Number of Products or 1 for No Products Available
        if let products = products, products.count > 0 {
            return products.count
        }
        return 1
    }
    
    // MARK: - Data for Row

    func dataForRow(at indexPath:IndexPath) -> (text: String, alignment:NSTextAlignment) {
        // Fetch Garment Product
        if let products = products, products.count > 0 {
            let product = products[indexPath.row]
            return (product.name ?? "", .left)
        }
        return (Message.noProducts.localized, .center)
    }
}
