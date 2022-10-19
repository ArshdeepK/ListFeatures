//
//  CustomTextField.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalizedText()
    }
    
    func setLocalizedText() {
        self.text = self.text?.localized
        self.placeholder = self.placeholder?.localized
    }
}
