//
//  CustomSegmentedControl.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalizedText()
    }
    
    func setLocalizedText() {
        if self.numberOfSegments > 0 {
            for segmentIndex in 0...self.numberOfSegments - 1 {
                self.setTitle(self.titleForSegment(at: segmentIndex)?.localized, forSegmentAt: segmentIndex)
            }
        }
    }
}
