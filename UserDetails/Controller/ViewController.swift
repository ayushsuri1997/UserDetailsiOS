//
//  ViewController.swift
//  UserDetails
//
//  Created by Ayush Suri on 11/07/20.
//  Copyright © 2020 Ayush Suri. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemArray = Welcome()
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        dataManager.fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Name: \(item.name)\nEmail: \(item.email)\nPhone: \(item.phone)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMap", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddressController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.add = itemArray[indexPath.row].address
        }
    }
    
}

//MARK: - DataManagerDelegate

extension ViewController: DataManagerDelegate {
    
    func didUpdateData(_ dataManager: DataManager, data: Welcome) {
        DispatchQueue.main.async {
            self.itemArray = data
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



