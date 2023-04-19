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
    
    lazy var bulaTitlePartOneLabel: UILabel = {
        let label = setLabel(text: "Bula", textColor: .systemPurple, font: "Impact", fontSize: 100)
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.shadowColor = .black
        return label
    }()
    
    lazy var bulaTitlePartTwoLabel: UILabel = {
        let label = setLabel(text: "Na", textColor: .systemBlue, font: "AmericanTypewriter-Bold", fontSize: 70)
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.shadowColor = .black
        return label
    }()
    
    lazy var bulaTitlePartThreeLabel: UILabel = {
        let label = setLabel(text: "Mão", textColor: .systemIndigo, font: "Impact", fontSize: 85)
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.shadowColor = .black
        return label
    }()
    
    lazy var emailTextField: UITextField = {
       return setTextField(placeHolder: "E-Mail")
    }()
    
    lazy var passwordTextField: UITextField = {
       return setTextField(placeHolder: "Senha")
    }()
    
    lazy var registerLabel: UILabel = {
        return setLabel(text: "Não é inscrito?", textColor: .black, font: "Arial-BoldMT", fontSize: 18)
    }()
    
    lazy var registerButton: UIButton = {
        return setButton()
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
        view.addSubview(bulaTitlePartOneLabel)
        view.addSubview(bulaTitlePartTwoLabel)
        view.addSubview(bulaTitlePartThreeLabel)
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
            
            bulaTitlePartOneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bulaTitlePartOneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 100),
            
            bulaTitlePartTwoLabel.centerXAnchor.constraint(equalTo: bulaTitlePartOneLabel.trailingAnchor),
            bulaTitlePartTwoLabel.topAnchor.constraint(equalTo: bulaTitlePartOneLabel.centerYAnchor),
            
            bulaTitlePartThreeLabel.centerXAnchor.constraint(equalTo: bulaTitlePartTwoLabel.leadingAnchor, constant: -20),
            bulaTitlePartThreeLabel.topAnchor.constraint(equalTo: bulaTitlePartTwoLabel.centerYAnchor, constant: -5),
            
            emailTextField.topAnchor.constraint(equalTo: bulaTitlePartThreeLabel.bottomAnchor, constant: 70),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -55),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 29),
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
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont(name: "Arial", size: 20)
        textField.layer.borderWidth = 0.5
        textField.delegate = self
        return textField
    }
    
    private func setLabel(text: String, textColor: UIColor, font: String, fontSize: Float) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: font, size: CGFloat(fontSize))
        label.text = text
        label.textColor = textColor
        return label
    }
    
    private func setButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique aqui", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 18)
        return button
    }

}

extension LoginViewController: UITextFieldDelegate {
    
}
