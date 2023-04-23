//
//  RegisterViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 20/04/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemTeal
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .yellow
        return content
    }()
    
    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Registre-se"
        label.font = UIFont(name: "Arial", size: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.shadowOffset = CGSize(width: 1, height: 1)
        label.shadowColor = .black
        return label
    }()
    
    lazy var perfilImageView: UIImageView = {
       setImageView(imageName: "person")
    }()
    
    lazy var userNameLabel: UILabel = {
        setLabel(text: "Nome Completo")
    }()
    
    lazy var emailLabel: UILabel = {
        setLabel(text: "E-mail")
    }()
    
    lazy var confirmEmailLabel: UILabel = {
        setLabel(text: "Confirmar E-mail")
    }()
    
    lazy var passwordLabel: UILabel = {
        setLabel(text: "Senha")
    }()
    
    lazy var confirmPasswordLabel: UILabel = {
       setLabel(text: "Confirmar Senha")
    }()
    
    lazy var genericTextField: UITextField = {
       setTextField()
    }()
    
    lazy var userNameTextField = genericTextField
    lazy var emailTextField = genericTextField
    lazy var confirmEmailTextField = genericTextField
    lazy var passwordTextField = genericTextField
    lazy var confirmPasswordTextField = genericTextField

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setComponents()
        setConstraints()
    }
    
    private func setComponents() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(registerLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            registerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            registerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            registerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70)
        ])
    }
    
    private func setImageView(imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    private func setTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont(name: "Arial", size: 20)
        textField.layer.borderWidth = 0.5
        textField.delegate = self
        return textField
    }
    
    private func setLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }
    
    private func setButton(text: String, textColor: UIColor, font: String, fontSize: Float) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont(name: font, size: CGFloat(fontSize))
        return button
    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
