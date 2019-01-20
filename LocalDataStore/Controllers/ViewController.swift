//
//  ViewController.swift
//  LocalDataStore
//
//  Created by Alex Braun on 1/12/19.
//  Copyright © 2019 Alex Braun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "cellIdentifier"
    var dataSource: [Phone] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    func setupController() {
        
        DataStoreManager.shared.isFileExists()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "updateDataSource"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhone))
        navigationItem.rightBarButtonItem = barButton
        
    }
    
    @objc func addPhone() {
        openDetails()
    }
    
    @objc func reloadData() {
        dataSource = PhoneBookManager.shared.phoneBook.phones
    }
    
    func openDetails() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailsVC")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Selected contact name is \(dataSource[indexPath.row].name) and phone is \(dataSource[indexPath.row].phone)")
    }
    
}

