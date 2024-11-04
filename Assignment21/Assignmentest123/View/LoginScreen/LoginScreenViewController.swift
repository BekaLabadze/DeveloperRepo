//
//  LoginScreen.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import UIKit

class LoginScreenViewController: UIViewController {
    let viewModel = LoginScreenViewModel()
    var profileIcon = UIImageView()
    let stackView = UIStackView()
    let userNameLabel = UILabel()
    let passwordLabel = UILabel()
    let confirmPasswordLabel = UILabel()
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let loginButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        setupView()
        checkLoggedIn()
    }
    
    private func setupStackView() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordLabel)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 30
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 35),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        userNameLabel.text = "Username"
        userNameLabel.textColor = .white
        userNameLabel.font = .systemFont(ofSize:20 , weight: .medium)
        userNameTextField.placeholder = "Enter username"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameTextField.backgroundColor = .white
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize:20 , weight: .medium)
        passwordLabel.textColor = .white
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmPasswordLabel.text = "Confirm Password"
        confirmPasswordLabel.textColor = .white
        confirmPasswordLabel.font = .systemFont(ofSize:20 , weight: .medium)
        confirmPasswordTextField.placeholder = "Enter password again"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupView() {
        profileIcon.image = UIImage.profileIcon
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileIcon)
        NSLayoutConstraint.activate([
            profileIcon.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            profileIcon.heightAnchor.constraint(equalToConstant: 98)
        ])
        setupStackView()
    }
    
    private func checkLoggedIn() {
        let status = viewModel.load()
        if status == nil {
            return
        } else {
            navigationController?.pushViewController(QuizScreenViewController(), animated: true)
        }
    }
    
    @objc private func loginButtonTapped() {
        if passwordTextField.text == confirmPasswordTextField.text {
            guard let text = passwordTextField.text else { return }
            viewModel.save(password: text)
            navigationController?.pushViewController(QuizScreenViewController(), animated: true)
        }
    }
}
