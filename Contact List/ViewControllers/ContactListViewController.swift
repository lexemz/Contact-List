//
//  ContactListViewController.swift
//  Contact List
//
//  Created by Igor on 02.10.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchContacts()
        
        tableView.rowHeight = 75
    }

    private func fetchContacts() {
        NetwokManager.shared.fetchContacts { contacts in
            DispatchQueue.main.async {
                self.contacts = contacts
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactViewCell
        
        let contact = contacts[indexPath.row]
        
        cell.configure(for: contact)
        return cell
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
