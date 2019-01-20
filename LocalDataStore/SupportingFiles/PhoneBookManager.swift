//
//  PhoneBookManager.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import Foundation

class PhoneBookManager: NSObject {
    
    static let shared = PhoneBookManager() // singletone
    
    var phoneBook: PhoneBook = PhoneBook(phones: [])
    
}
