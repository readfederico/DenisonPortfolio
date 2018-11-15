//
//  SlayterTableViewController.swift
//  DatabaseDine
//
//  Created by Jacob on 12/4/17.
//  Copyright © 2017 Jacob. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SlayterTableViewController: UITableViewController {
    
    var dbRef:DatabaseReference!
    var sweets = [Sweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child("Slayter")
        startObservingDB()
    }
    
    
    func startObservingDB () {
        dbRef.observe(.value, with: { (snapshot:DataSnapshot) in
            var newSweets = [Sweet]()
            
            for sweet in snapshot.children {
                let sweetObject = Sweet(snapshot: sweet as! DataSnapshot)
                newSweets.append(sweetObject)
            }
            
            self.sweets = newSweets
            self.tableView.reloadData()
            
        })
    }
    
    @IBAction func addSweet(_ sender: Any) {
        
        let sweetAlert = UIAlertController(title:"New Comment", message: "Enter your Comment", preferredStyle: .alert)
        sweetAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Your comment"
        }
        sweetAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            let sweetContent = sweetAlert.textFields?.first?.text
            
            let sweetAlert2 = UIAlertController(title:"Name", message: "Enter your Name", preferredStyle: .alert)
            sweetAlert2.addTextField { (textField:UITextField) in
                textField.placeholder = "Your name"
            }
            sweetAlert2.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
                
                if let sweetName = sweetAlert2.textFields?.first?.text {
                    let sweet = Sweet(content: sweetContent!, addedByUser: sweetName)
                    
                    let sweetRef = self.dbRef.child(sweetName.lowercased())
                    
                    sweetRef.setValue(sweet.toAnyObject())
                }
            }))
            self.present(sweetAlert2, animated: true, completion: nil)
        }))
        self.present(sweetAlert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sweets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellS", for: indexPath)
        
        let sweet = sweets[indexPath.row]
        
        cell.textLabel?.text = sweet.content
        cell.detailTextLabel?.text = sweet.addedByUser
        
        return cell
    }
    
    
    
    
    
}
