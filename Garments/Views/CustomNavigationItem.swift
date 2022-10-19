//
//  CustomNavigationItem.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class CustomNavigationItem: UINavigationItem {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalizedText()
    }
    
    func setLocalizedText() {
        self.title = self.title?.localized
    }
}
