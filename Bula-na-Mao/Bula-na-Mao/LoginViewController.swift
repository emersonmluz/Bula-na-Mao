//
//  ViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 19/04/23.
//

import UIKit

final class LoginViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        return setImageView(imageName: "Background")
    }()
    
    lazy var titleImageView: UIImageView = {
       return setImageView(imageName: "Title")
    }()
    
    lazy var emailTextField: UITextField = {
       return setTextField(placeHolder: "E-Mail")
    }()
    
    lazy var passwordTextField: UITextField = {
       return setTextField(placeHolder: "Senha")
    }()
    
    var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.text = "Não é inscrito?"
        label.textColor = .black
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique aqui", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 18)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        configComponents()
        setComponents()
        setConstraints()
    }
    
    private func configComponents() {
        view.backgroundColor = .white
    }
    
    private func setComponents() {
        view.addSubview(backgroundImage)
        view.addSubview(titleImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerLabel)
        view.addSubview(registerButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            titleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,  constant: -140),
            titleImageView.heightAnchor.constraint(equalToConstant: 300),
            titleImageView.widthAnchor.constraint(equalToConstant: 300),
            
            emailTextField.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -55),
            
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -43),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 5)
        ])
    }

    private func setImageView(imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    private func setTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont(name: "Arial", size: 20)
        textField.layer.borderWidth = 0.8
        textField.delegate = self
        return textField
    }

}

extension LoginViewController: UITextFieldDelegate {
    
}
