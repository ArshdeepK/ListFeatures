//
//  Configuration.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import Foundation

enum MyConfig {
    case RUN
    case TEST
}

struct CONFIG {

    // Change this as per the build state
    static var SELECTED: MyConfig = .RUN
    
    //get the selected server
    static func buildConfig(config: MyConfig = SELECTED) -> MyConfig {
        return config
    }
}
