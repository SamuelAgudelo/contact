//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Samuel Agudelo on 10/12/20.
//

import UIKit

protocol UpdateContactDelegate {
    func UpdateContact(contact: Contact, index: Int)
}

class EditContactViewController: UIViewController {
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    var fullname = String()
    var phoneNumber = Int()
    var age = Int()
    
    var delegate: UpdateContactDelegate?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullnameTextField.delegate = self

        fullnameTextField.text = fullname
        phoneNumberTextField.text = String(phoneNumber)
        ageTextField.text = String(age)
        
        phoneNumberTextField.keyboardType = .numberPad
        ageTextField.keyboardType = .numberPad
        
        fullnameTextField.placeholder = "Full Name"
        phoneNumberTextField.placeholder = "Phone Number"
        ageTextField.placeholder = "Years"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc func didTapDone() {
                
        if let fullName = fullnameTextField.text, !fullName.isEmpty, !phoneNumberTextField.text!.isEmpty, !ageTextField.text!.isEmpty {
            
            let contact = Contact(fullName: fullName, phoneNumber: Int(phoneNumberTextField.text!)!, age: Int(ageTextField.text!)!)
            print(contact.fullName)
            print("Index: \(index)")
            
            delegate?.UpdateContact(contact: contact, index: index)
        } else {
            let alert = UIAlertController(title: "Incomplete Text Fields", message: "Remember that in order to update a contact you must fill in all the text fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension EditContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fullnameTextField.endEditing(true)
    }
    
}
