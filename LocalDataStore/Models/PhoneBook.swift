//
//  PhoneBook.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import Foundation

class PhoneBook: NSObject, Codable {
    
    var phones: [Phone]
    
    init(phones: [Phone]) {
        self.phones = phones
    }
    
}
