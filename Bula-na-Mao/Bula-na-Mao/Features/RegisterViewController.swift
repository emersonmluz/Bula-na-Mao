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
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var loadPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Carregar Foto", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 16)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(loadPhoto(_:)), for: .touchUpInside)
        return button
    }()
    
    let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var registerButton: MainButton = {
        let button = MainButton()
        button.titleButton = .register
        button.addTarget(self, action: #selector(saveUser(_:)), for: .touchUpInside)
        return button
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
    
    lazy var userNameTextField: UITextField = {
       setTextField()
    }()
    
    lazy var emailTextField: UITextField = {
       setTextField()
    }()
    
    lazy var confirmEmailTextField: UITextField = {
       setTextField()
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = setTextField()
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = setTextField()
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    let loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.isHidden = true
        return view
    }()
    
    let activityLoading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanFields()
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
        contentView.addSubview(perfilImageView)
        contentView.addSubview(loadPhotoButton)
        contentView.addSubview(dataStackView)
        dataStackView.addArrangedSubview(userNameLabel)
        dataStackView.addArrangedSubview(userNameTextField)
        dataStackView.addArrangedSubview(emailLabel)
        dataStackView.addArrangedSubview(emailTextField)
        dataStackView.addArrangedSubview(confirmEmailLabel)
        dataStackView.addArrangedSubview(confirmEmailTextField)
        dataStackView.addArrangedSubview(passwordLabel)
        dataStackView.addArrangedSubview(passwordTextField)
        dataStackView.addArrangedSubview(confirmPasswordLabel)
        dataStackView.addArrangedSubview(confirmPasswordTextField)
        contentView.addSubview(registerButton)
        view.addSubview(loadingView)
        loadingView.addSubview(activityLoading)
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
            registerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            
            perfilImageView.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 50),
            perfilImageView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -60),
            perfilImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 60),
            perfilImageView.heightAnchor.constraint(equalToConstant: 120),
            
            loadPhotoButton.topAnchor.constraint(equalTo: perfilImageView.bottomAnchor, constant: 10),
            loadPhotoButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -60),
            loadPhotoButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 60),
            
            dataStackView.topAnchor.constraint(equalTo: loadPhotoButton.bottomAnchor, constant: 50),
            dataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: dataStackView.bottomAnchor, constant: 50),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 45),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityLoading.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityLoading.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ])
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
        NSLayoutConstraint.activate([textField.heightAnchor.constraint(equalToConstant: 40)])
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
    
    @objc private func loadPhoto(_: UIButton) {
        let alert = UIAlertController(title: "Carregar Foto", message: "Acesse a camera para tirar uma foto ou selecione da galeria.", preferredStyle: .alert)
        let actionCamera = UIAlertAction(title: "Camera", style: .default) {_ in
            self.getImageFromCamera()
        }
        let actionLibrary = UIAlertAction(title: "Galeria", style: .default) {_ in
            self.getImageFromPictureLibrary()
        }
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.view.backgroundColor = .white
        present(alert, animated: true)
    }

    @objc private func saveUser(_: UIButton) {
        guard dataValidation() else {return}
        
        let name = userNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let photo = perfilImageView.image?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        
        loadingView.isHidden = false
        activityLoading.startAnimating()
        
        FirebaseManager.shared.saveUserData(name: name, email: email, password: password, photo: photo) { title, message, actionTitle in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionTitle, style: .default) {_ in
                if title == "Sucesso" {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            alert.addAction(action)
            alert.view.backgroundColor = .white
            
            self.loadingView.isHidden = true
            self.activityLoading.stopAnimating()
            
            self.present(alert, animated: true)
        }
    }
    
    private func cleanFields() {
        userNameTextField.text = ""
        emailTextField.text = ""
        confirmEmailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        perfilImageView.image = UIImage(systemName: "person.fill")
    }
    
    private func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(action)
        alert.view.backgroundColor = .white
        self.present(alert, animated: true)
    }
    
    private func dataValidation() -> Bool {
        guard Validations.shared.validateFullName(fullName: userNameTextField.text ?? ""),
              Validations.shared.validateEmail(email: emailTextField.text ?? ""),
              Validations.shared.validatePassword(password: passwordTextField.text ?? "")
        else {
            showAlert(title: "Atenção", message: "* O nome deve conter pelo menos um sobrenome;\n\n" +
                            "* O email não deve conter espaços e deve ser um email válido;\n\n" +
                            "* A senha deve conter 6 dígitos, pelo menos 1 caracter especial e 1 número.", actionTitle: "Entendi")
            return false}
        
        if emailTextField.text?.lowercased() != confirmEmailTextField.text?.lowercased() {
            showAlert(title: "Atenção", message: "Confirmação de E-mail não corresponde ao E-mail digitado", actionTitle: "Entendi")
            return false
        } else if passwordTextField.text?.lowercased() != confirmPasswordTextField.text?.lowercased() {
            showAlert(title: "Atenção", message: "Confirmação de senha não corresponde a senha digitada.", actionTitle: "Entendi")
            return false
        } else {
            return true
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getImageFromPictureLibrary() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        guard let mediaType = UIImagePickerController.availableMediaTypes(for: .photoLibrary) else {return}
        imagePicker.mediaTypes = mediaType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func getImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            guard let midiaType = UIImagePickerController.availableMediaTypes(for: .camera) else {return}
            imagePicker.mediaTypes = midiaType
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            showAlert(title: "Acesso negado!", message: "Você não possui acesso a camera.", actionTitle: "OK")
        }
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {return}
        dismiss(animated: true)
        perfilImageView.image = image
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
