//
//  ProfileViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    private let store = DataStoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar()
        getUserData()
    }
}

extension ProfileViewController {
    private func setNavbar() {
        self.navigationItem.title = "Profile"
    }
    
    private func getUserData() {
        let userData = store.loadUser()
        let currentUserEmail = Auth.auth().currentUser?.email
        for user in userData {
            if user.email == currentUserEmail {
                guard let age = user.age,
                      let firstName = user.firstName,
                      let lastName = user.lastName,
                      let phoneNumber = user.phoneNumber,
                      let email = user.email,
                      let password = user.password
                else { return }
                self.firstNameLabel.text = "First name: \(firstName)"
                self.lastNameLabel.text = "Last name: \(lastName)"
                self.ageLabel.text = "Birthday: \(DateFormatter.dateFormatter.string(from: age))"
                self.phoneNumberLabel.text = "Phone number: \(phoneNumber)"
                self.emailLabel.text = "Email: \(email)"
                self.passwordLabel.text = "Password: \(password)"
            }
        }
    }
}

