//
//  ViewController.swift
//  Contacts
//
//  Created by Samuel Agudelo on 9/12/20.
//

import UIKit

struct Contact {
    var fullName: String
    var phoneNumber: Int
    var age: Int
}

class ContactsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: - Properties
    
    var contacts = [Contact]()
    let index = 0
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        contacts.append(Contact(fullName: "Samuel Agudelo", phoneNumber: 3145556081, age: 12))
        contacts.append(Contact(fullName: "Matias Agudelo", phoneNumber: 3114292465, age: 11))
        
        setupUI()
        
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    // MARK: - didTapAdd()
    
    @objc func didTapAdd() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "AddContactVC") as? AddContactViewController else { return }
        vc.title = "New Contact"
        vc.delegate = self
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    // MARK: cellForRowAt
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].fullName
        cell.detailTextLabel?.text = String(contacts[indexPath.row].phoneNumber)
        return cell
    }
    
    // MARK: didSelectRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Hace que desaparesca le selecion cuando se hace click
        contactsTableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(identifier: "previewVC") as? PreviewViewController else { return }
        vc.fullname = contacts[indexPath.row].fullName
        vc.phoneNumber = contacts[indexPath.row].phoneNumber
        vc.age = contacts[indexPath.row].age
        vc.index = indexPath.row
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}

// MARK: - AddContactDelegate

extension ContactsViewController: AddContactDelegate, UpdateContactDelegate {

    func addContact(contact: Contact) {
        self.dismiss(animated: true) {
            self.contacts.append(contact)
            self.contactsTableView.reloadData()
        }
    }
    
    func UpdateContact(contact: Contact, index: Int) {
        self.contacts.insert(contact, at: index)
    }
    
}
