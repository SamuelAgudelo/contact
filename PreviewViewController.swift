//
//  PreviewViewController.swift
//  Contacts
//
//  Created by Samuel Agudelo on 10/12/20.
//

import UIKit

class PreviewViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK: - Properties
    
    var fullname = String()
    var phoneNumber = Int()
    var age = Int()
    
    var index = 1
    var contacts = [Contact]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Preview Contact"
        
        fullnameLabel.text = fullname
        phoneNumberLabel.text = String(phoneNumber)
        ageLabel.text = String(age)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
    }
    
    // MARK: - Actions
    
    @objc func didTapCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapEdit() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "editContactVC") as? EditContactViewController else { return }
        vc.title = "Edit Contact"
        vc.fullname = fullname
        vc.phoneNumber = phoneNumber
        vc.age = age
        vc.index = index
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UpdateContactDelegate

extension PreviewViewController: UpdateContactDelegate {
    
    func UpdateContact(contact: Contact, index: Int) {
        
        // Going back to the previous controller
        navigationController?.popViewController(animated: true)
        
        // Adding the contact to the array
        self.contacts.append(contact)
        
        // Assigning values ​​and text of the fullname
        self.fullname = contacts[index].fullName
        fullnameLabel.text = fullname
        
        // Assigning values ​​and text of the phoneNumber
        self.phoneNumber = contacts[index].phoneNumber
        phoneNumberLabel.text = String(phoneNumber)
        
        // Assigning values ​​and text of the age
        self.age = contacts[index].age
        ageLabel.text = String(age)
    }
    
}
