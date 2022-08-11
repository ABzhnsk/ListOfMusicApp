//
//  SignUpViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 10.08.2022.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.textColor = UIColor.purpureColor
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        return textField
    }()
    
    private let lastNameValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Birthday"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.requiredColor
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.tintColor = .black
        return datePicker
    }()
    
    private var elementsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstraint()
        setUpDelegate()
    }
    
}

extension SignUpViewController {    
    private func setUpViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           lastNameTextField,
                                                           lastNameValidLabel,
                                                           birthdayLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneNumberTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel
                                                          ])
        elementsStackView.axis = .vertical
        elementsStackView.spacing = 10
        elementsStackView.distribution = .fillProportionally
        SettingsUI.styleTextField(firstNameTextField)
        SettingsUI.styleTextField(lastNameTextField)
        SettingsUI.styleTextField(phoneNumberTextField)
        SettingsUI.styleTextField(emailTextField)
        SettingsUI.styleTextField(passwordTextField)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(signUpLabel)
        SettingsUI.styleFilledButton(signUpButton)
        backgroundView.addSubview(signUpButton)
    }
    
    private func setConstraint() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
        backgroundView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(scrollView)
            make.height.equalTo(view.snp.height)
            make.width.equalTo(view)
        }
        elementsStackView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(backgroundView)
            make.top.equalTo(signUpLabel).inset(60)
            make.leading.trailing.equalTo(view).inset(20)
        }
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(20)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.bottom.equalTo(elementsStackView).offset(60)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func setUpDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}
