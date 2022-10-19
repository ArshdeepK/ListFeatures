//
//  AddNewGarmentViewModel.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import Foundation

class AddNewGarmentViewModel {
    let databaseAccess: DatabaseAccess
    
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
    
    var showAlertClosure: (()->())?

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    // MARK: - Save Product
    
    func saveProduct(name:String) {
        DatabaseAccess().saveProduct(name: name) { error in
            if error != nil {
                self.alertMessage = Alert.saveError.localized + " " + error!.localizedDescription
            }
        }
    }
}
