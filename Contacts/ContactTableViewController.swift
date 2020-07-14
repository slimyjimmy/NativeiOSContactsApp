//
//  ContactTableViewController.swift
//  Contacts
//
//  Created by Djimon Nowak on 13.07.20.
//  Copyright © 2020 Djimon Nowak. All rights reserved.
//

import UIKit
import os.log

class ContactTableViewController: UITableViewController{
    
    //MARK: Properties
    var contacts = [Contact]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        } else {
            loadSampleContacts()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell  else {
            fatalError("The dequeued cell is not an instance of Contact bro bro bro.")
        }
        let contact = contacts[indexPath.row]

        if (contact.pathToPhoto != nil) {
            cell.ImageView_Avatar.image = UIImage(contentsOfFile: contact.pathToPhoto!)
        } else {
            cell.ImageView_Avatar.image = UIImage(named: "defaultImage")
        }
        
        cell.Label_Name.text = contact.name

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContacts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "Add Item":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        
        case "ShowDetail":
            guard let contactDetailViewController = //segue.destination as? ContactViewController else {
                segue.destination as? ContactDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
             
            guard let selectedContactCell = sender as? ContactTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
             
            guard let indexPath = tableView.indexPath(for: selectedContactCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
             
            let selectedContact = contacts[indexPath.row]
            contactDetailViewController.contact = selectedContact
        
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactViewController, let contact = sourceViewController.contact {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                contacts[selectedIndexPath.row] = contact
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                //Add a new contact to tableView
                let newIndexPath = IndexPath(row: contacts.count, section: 0)
                
                contacts.append(contact)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveContacts()
        }
    }
    
    //MARK: Private Methods
     
    private func loadSampleContacts() {
        guard let contact1 = Contact(pathToPhoto: nil, name: "Jimmy", number: "1100") else {
            fatalError("moinnnnnn")
        }
        guard let contact2 = Contact(pathToPhoto: nil, name: "Peter", number: "2100") else {
            fatalError("moinnnn2nn")
        }
        contacts += [contact1, contact2]
    }
    
    private func saveContacts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }

}
