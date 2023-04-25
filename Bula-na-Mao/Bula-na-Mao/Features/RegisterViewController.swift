//
//  RegisterViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 20/04/23.
//

import UIKit
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let dataBase = Firestore.firestore()
    var ref: DocumentReference?
    
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
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.7
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
       setTextField()
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
       setTextField()
    }()
    
    let imagePicker = UIImagePickerController()
    var imagePickedByUser: UIImage? {
        get {
            return perfilImageView.image
        }
        set {
            perfilImageView.image = newValue
        }
    }

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
            registerButton.heightAnchor.constraint(equalToConstant: 45)
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
    
    private func setButton(text: String, textColor: UIColor, font: String, fontSize: Float) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont(name: font, size: CGFloat(fontSize))
        return button
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
        ref = dataBase.collection("users").addDocument(data: [
            "name": userNameTextField.text ?? "Não informado",
            "email": emailTextField.text ?? "Não informado",
            "password": passwordTextField.text ?? "Não informado"
        ]) { error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Retornar", style: .default)
                alert.addAction(action)
                alert.view.backgroundColor = .white
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Sucesso", message: "Registro realizado com sucesso.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Retornar", style: .default)
                alert.addAction(action)
                alert.view.backgroundColor = .white
                self.present(alert, animated: true)
            }
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
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {return}
        dismiss(animated: true)
        imagePickedByUser = image
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
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
            let alert = UIAlertController(title: "Acesso negado!", message: "Você não possui acesso a camera.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}
