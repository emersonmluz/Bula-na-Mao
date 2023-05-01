//
//  ViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 19/04/23.
//

import UIKit

class LoginViewController: UIViewController {
    var navigation: UINavigationController?
    
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
        let textField = setTextField(placeHolder: "Senha")
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    lazy var loginButton: MainButton = {
        let button = MainButton()
        button.addTarget(self, action: #selector(tapLoginButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var registerLabel: UILabel = {
        return setLabel(text: "Não é inscrito?", textColor: .black, font: "Arial-BoldMT", fontSize: 18)
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique aqui", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: CGFloat(18))
        button.addTarget(self, action: #selector(tapRegisterButton(_:)), for: .touchUpInside)
        return button
    }()
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigation?.isNavigationBarHidden = true
    }
    
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
        view.addSubview(loginButton)
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
            
            bulaTitlePartThreeLabel.centerXAnchor.constraint(equalTo: bulaTitlePartTwoLabel.leadingAnchor, constant: -25),
            bulaTitlePartThreeLabel.topAnchor.constraint(equalTo: bulaTitlePartTwoLabel.centerYAnchor, constant: -15),
            
            emailTextField.topAnchor.constraint(equalTo: bulaTitlePartThreeLabel.bottomAnchor, constant: 70),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 4),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: -2),
            
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerLabel.trailingAnchor.constraint(equalTo: registerButton.leadingAnchor, constant: -5)
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
        textField.font = UIFont(name: "Arial", size: 18)
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    @objc private func tapRegisterButton(_: UIButton) {
        goTo(controller: RegisterViewController())
    }
    
    @objc private func tapLoginButton(_: UIButton) {
        FirebaseManager.shared.authLogin(email: emailTextField.text?.lowercased() ?? "", senha: passwordTextField.text?.lowercased() ?? "") { [weak self] title, message, actionTitle in
            guard title == "", message == "", actionTitle == "" else {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: actionTitle, style: .default)
                alert.addAction(action)
                alert.view.backgroundColor = .white
                self?.present(alert, animated: true)
                return
            }
            self?.goTo(controller: MainPageViewController())
        }
    }
    
    private func goTo(controller: UIViewController) {
        navigation?.pushViewController(controller, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
