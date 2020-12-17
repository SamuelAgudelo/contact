//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Samuel Agudelo on 9/12/20.
//

import UIKit

// MARK: - AddContactDelegate

protocol AddContactDelegate {
    func addContact(contact: Contact)
}

class AddContactViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    // MARK: - Properties
    
    var delegate: AddContactDelegate?
        
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up visual interface
        setupUI()
        
        fullNameTextField.delegate = self
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        
        // Settings up text fields
        textField()
        
        // Adding button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    // MARK: - TextField
    
    private func textField() {
        
        // Full Name
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.keyboardType = .default
        fullNameTextField.becomeFirstResponder()
        
        // Phone Number
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.keyboardType = .numberPad
        
        // Years
        ageTextField.placeholder = "Years"
        ageTextField.keyboardType = .numberPad
    }
    
    // MARK: - Actions
    
    // MARK: didTapDone
    
    @objc func didTapDone() {
        
        if let fullName = fullNameTextField.text, !fullName.isEmpty, !phoneNumberTextField.text!.isEmpty, !ageTextField.text!.isEmpty {
            let contact = Contact(fullName: fullName, phoneNumber: Int(phoneNumberTextField.text!)!, age: Int(ageTextField.text!)!)
            delegate?.addContact(contact: contact)
        } else {
            let alert = UIAlertController(title: "Incomplete Text Fields", message: "Remember that in order to add a contact you must fill in all the text fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: didTapSave
    
    @objc func didTapSave() {
        
    }
    
    // MARK: didTapCancel
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fullNameTextField.endEditing(true)
    }
        
}
