//
//  BulaViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 20/04/23.
//

import UIKit

class MainPageViewController: UIViewController {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        return view
    }()
    
    lazy var perfilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 18)
        label.text = "Rambo Cabra Grossa e Forte"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    lazy var historyButton: CustomSegmentedControl = {
        let button = CustomSegmentedControl()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleButton(title: "Histórico")
        button.button.addTarget(self, action: #selector(historyButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton: CustomSegmentedControl = {
        let button = CustomSegmentedControl()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleButton(title: "Favoritos")
        button.isActive(false)
        button.button.addTarget(self, action: #selector(favoriteButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Pesquisar"
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "Arial", size: 18)
        textField.layer.borderWidth = 0.1
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        configComponents()
        setComponents()
        setConstraint()
    }
    
    private func configComponents() {
        view.backgroundColor = .systemGray6
        perfilImageView.layer.cornerRadius = perfilImageView.bounds.height / 2
    }
    
    private func setComponents() {
        view.addSubview(containerView)
        containerView.addSubview(perfilImageView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(historyButton)
        containerView.addSubview(favoriteButton)
        view.addSubview(searchTextField)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            perfilImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            perfilImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            perfilImageView.heightAnchor.constraint(equalToConstant: 50),
            perfilImageView.widthAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.topAnchor.constraint(equalTo: perfilImageView.centerYAnchor, constant: -5),
            userNameLabel.leadingAnchor.constraint(equalTo: perfilImageView.trailingAnchor, constant: 15),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            historyButton.topAnchor.constraint(equalTo: perfilImageView.bottomAnchor, constant: 10),
            historyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            historyButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
            historyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            historyButton.heightAnchor.constraint(equalToConstant: 60),
            
            favoriteButton.centerXAnchor.constraint(equalTo: historyButton.centerXAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60),
            
            searchTextField.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc private func historyButtonAction(_: CustomSegmentedControl) {
        historyButton.isActive(true)
        favoriteButton.isActive(false)
    }
    
    @objc private func favoriteButtonAction(_: CustomSegmentedControl) {
        favoriteButton.isActive(true)
        historyButton.isActive(false)
    }
}
