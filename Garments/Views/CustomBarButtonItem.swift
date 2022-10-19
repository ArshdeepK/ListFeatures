//
//  CustomBarButtonItem.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class CustomBarButtonItem: UIBarButtonItem {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalizedText()
    }
    
    func setLocalizedText() {
        self.title = self.title?.localized
    }
}
