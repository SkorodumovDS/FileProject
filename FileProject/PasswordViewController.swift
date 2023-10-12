//
//  PasswordViewController.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 12.10.2023.
//

import UIKit
import KeychainSwift

class PasswordViewController: UIViewController {
    private lazy var savedPassword  = ""
    private lazy var firstPassword  = ""
    
    private lazy var password: UITextField = { [unowned self] in
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Enter password here"
        textField.font = UIFont.systemFont(ofSize: 16)
        //textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let buttonLog = CustomButton(title: "Создать пароль", titleColor: .white, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.buttonPressed()
        }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog
        
    }()
    
    private let coordinator : DocumentCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = KeychainSwift()
        if let savedKeyPassword = keychain.get("password") {
            if savedKeyPassword.isEmpty {
                loginButton.setTitle("Создать пароль", for: .normal)
            }
            else {
                loginButton.setTitle("Введите пароль", for: .normal)
                savedPassword = savedKeyPassword}
        }else {
            loginButton.setTitle("Создать пароль", for: .normal)
            savedPassword = ""
        }
        
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    init(coordinator: DocumentCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            password.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            password.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            password.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 220),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),
            loginButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            loginButton.topAnchor.constraint(
                equalTo: password.bottomAnchor,
                constant: 16.0
            ),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
    }
    
    @objc func buttonPressed() {
        if savedPassword.isEmpty{
            if firstPassword.isEmpty {
                if password.text!.count < 4 {
                    let alert = UIAlertController(title: "Пароль меньше 4 символов", message: "Введите пароль заново", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ввести заново", comment: "Ввести пароль заново"), style: .default, handler: { _ in
                        self.firstPassword = ""
                        self.loginButton.setTitle("Создать пароль", for: .normal)
                        self.password.text = ""
                    }))
                    self.present(alert, animated: true)
                }else {
                    firstPassword = password.text!
                    loginButton.setTitle("Повторите пароль", for: .normal)
                    password.text = ""
                }
            }else {
                if firstPassword == password.text! {
                    let keychain = KeychainSwift()
                    keychain.set(firstPassword, forKey: "password")
                    coordinator.navControlles = navigationController
                    coordinator.showNextScreen()
                }else {
                    let alert = UIAlertController(title: "Пароли не совпадают", message: "Введите пароли заново", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ввести заново", comment: "Ввести пароли заново"), style: .default, handler: { _ in
                        self.firstPassword = ""
                        self.loginButton.setTitle("Создать пароль", for: .normal)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }else {
            if savedPassword == password.text! {
                coordinator.showNextScreen()
            }else {
                let alert = UIAlertController(title: "Неверный пароль", message: "Введите пароль заново", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ввести заново", comment: "Ввести пароль заново"), style: .default, handler: { _ in
                    self.firstPassword = ""
                    self.loginButton.setTitle("Ввести пароль", for: .normal)
                }))
                self.present(alert, animated: true)
            }
        }
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
    }

    private func addSubviews() {
        view.addSubview(password)
        view.addSubview(loginButton)
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
