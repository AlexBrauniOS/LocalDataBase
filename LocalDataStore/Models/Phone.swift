//
//  Phone.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import Foundation

class Phone: NSObject, Codable {
    
    var name: String
    var phone: String
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
}
