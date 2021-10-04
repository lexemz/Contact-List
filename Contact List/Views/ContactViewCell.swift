//
//  ContactViewCell.swift
//  Contact List
//
//  Created by Igor on 04.10.2021.
//

import UIKit

class ContactViewCell: UITableViewCell {
    
    
    @IBOutlet var contactImage: UIImageView!
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
        let defaultErrorImage = UIImage(systemName: "person.crop.circle")
        
        DispatchQueue.global().async {
            let imageData = NetwokManager.shared.fetchImage(from: contact.picture.large)
            
            guard let imageData = imageData else {
                DispatchQueue.main.async {
                    self.contactImage.image = defaultErrorImage
                }
                return
            }
            DispatchQueue.main.async {
                self.contactImage.image = UIImage(data: imageData)
            }
        }
    }
}
