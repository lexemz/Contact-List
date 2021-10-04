//
//  ContactViewCell.swift
//  Contact List
//
//  Created by Igor on 04.10.2021.
//

import UIKit

class ContactViewCell: UITableViewCell {
    @IBOutlet var contactImage: ContactImageView!
    @IBOutlet var contactTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contactImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(for contact: Contact) {
        contactTitle.text = contact.name.fullName
        contactImage.fetchImage(from: contact.picture.large)
    }
}
