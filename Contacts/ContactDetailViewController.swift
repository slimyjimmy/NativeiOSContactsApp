//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Djimon Nowak on 14.07.20.
//  Copyright © 2020 Djimon Nowak. All rights reserved.
//

import UIKit
import os.log

class ContactDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var imageView_avatar: UIImageView!
    @IBOutlet weak var label_Name: UILabel!
    @IBOutlet weak var label_Number: UILabel!
    
    var contact: Contact?

    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = contact {
            label_Name.text = contact.name
            label_Number.text = contact.number
            if (contact.pathToPhoto != nil) {
                imageView_avatar.image = UIImage(contentsOfFile: contact.pathToPhoto!)
            } else {
                imageView_avatar.image = UIImage(named: "defaultImage")
            }
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let contactEditViewController = segue.destination as? ContactViewController else {
            fatalError("Unexpedected bratan")
        }
        contactEditViewController.contact = contact!
    }
    
    //MARK: Actions
    @IBAction func openTextMessage(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "sms://" + contact!.number!), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    @IBAction func dialNumber(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "tel://" + contact!.number!), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
