//
//  DetailsViewController.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBAction func addButton(_ sender: UIButton) {
        
        let phone = Phone(name: nameField.text ?? "no name", phone: phoneField.text ?? "no phone")
        
        PhoneBookManager.shared.phoneBook.phones.append(phone)
        DataStoreManager.shared.saveData()
        
    }
    
}
