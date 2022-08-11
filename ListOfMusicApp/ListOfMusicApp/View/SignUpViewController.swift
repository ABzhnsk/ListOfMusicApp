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
        view.backgroundColor = UIColor(red: 255/255, green: 158/255, blue: 109/255, alpha: 1)
        return view
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last Name"
        return textField
    }()
    
    private let lastNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    private var elementsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstraint()
        setUpDelegate()
        setupDataPicker()
    }
    
}

extension SignUpViewController {
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    private func setUpViews() {
        title = "Registration"
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        elementsStackView = UIStackView(arrangedSubviews: [firstNameValidLabel,
                                                           firstNameTextField,
                                                           lastNameValidLabel,
                                                           lastNameTextField,
                                                           ageValidLabel,
                                                           datePicker,
                                                           phoneValidLabel,
                                                           phoneNumberTextField,
                                                           emailValidLabel,
                                                           emailTextField,
                                                           passwordValidLabel,
                                                           passwordTextField
                                                          ])
        elementsStackView.axis = .vertical
        elementsStackView.spacing = 10
        elementsStackView.distribution = .fillProportionally
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
            make.height.equalTo(view)
            make.width.equalTo(view)
        }
        elementsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(backgroundView)
            make.leading.trailing.equalTo(backgroundView).inset(20)
        }
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(elementsStackView).offset(-30)
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
