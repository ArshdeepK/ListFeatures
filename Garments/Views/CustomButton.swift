//
//  CustomButton.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalizedText()
    }
    
    func setLocalizedText() {
        self.setTitle(self.titleLabel?.text?.localized, for: .normal)
    }
}
