//
//  DataStoreManager.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import Foundation

class DataStoreManager: NSObject {
    
    static let shared = DataStoreManager()
    
    private let fileManager = FileManager.default
    private let fileName = "PhoneBook"
    private let fileFormat = "txt"
    private var filePath = ""
    
    let phoneBookManager = PhoneBookManager.shared
    
    func isFileExists() {
        filePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName).appendingPathExtension(fileFormat).path ?? ""
        
        if fileManager.fileExists(atPath: filePath) {
            readFromFile()
        } else {
            print("File not found")
            createFile()
        }
    }
    
    func createFile() {
        print("Create file")
        
        do {
            _ = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName).appendingPathExtension(fileFormat)
            saveData()
            readFromFile()
        } catch let error as NSError {
            print("Error when create new file: \(error)")
        }
    }
    
    func saveData() {
        print("write to file")
        
        do {
            print("the text was successfully written")
            
            try getJson(from: phoneBookManager.phoneBook).write(to: (fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName).appendingPathExtension(fileFormat))!, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("write to file with error: \(error)")
        }
    }
    
    func readFromFile() {
        print("Read from file")
        
        do {
            let myJsonStr = try String(contentsOfFile: (fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName).appendingPathExtension(fileFormat).path)!)
            print("my json from file: \(myJsonStr)")
            
            // need to convert string to data here!!!
            if let newModels = getNewModels(from: myJsonStr) {
                print("Converting string to new models from new file was successful")
                phoneBookManager.phoneBook = newModels
            } else {
                print("Converting string to new models from new file was ended with error")
            }
        } catch let error as NSError {
            print("read from file with error: \(error)")
        }
        print("MainFolder: \(phoneBookManager.phoneBook)")
    }
    
    // encoding JSON
    func getJson(from model: PhoneBook) -> String {
        
        // get data from models
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(model)
        
        guard let data = encodedData else { return "" }
        
        // convert data to string
        guard let jsonStr = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        print("json string: \(jsonStr)")
        
        return jsonStr
    }
    
    // decoding JSON
    func getNewModels(from string: String) -> PhoneBook? {
        var model: PhoneBook?
        
        // convert string to data
        guard let data = string.data(using: .utf8) else { return nil }
        print("data: \(data)")
        
        // get models from data
        do {
            let decodedModel = try JSONDecoder().decode(PhoneBook.self, from: data)
            model = decodedModel
        } catch let error as NSError {
            print("Decoding JSON with error: \(error)")
        }
        
        return model
    }
    
    
}
