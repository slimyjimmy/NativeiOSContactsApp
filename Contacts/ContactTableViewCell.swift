//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Djimon Nowak on 13.07.20.
//  Copyright © 2020 Djimon Nowak. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var Label_Name: UILabel!
    @IBOutlet weak var ImageView_Avatar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
