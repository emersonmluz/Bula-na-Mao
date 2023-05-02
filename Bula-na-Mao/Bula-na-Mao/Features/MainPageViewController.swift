//
//  BulaViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 20/04/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MainPageViewController: UIViewController {
    var medicines: MedicineResponse?
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        return view
    }()
    
    lazy var perfilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    lazy var historyButton: MainSegmentedControl = {
        let button = MainSegmentedControl()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleButton(title: "Histórico")
        button.button.addTarget(self, action: #selector(historyButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton: MainSegmentedControl = {
        let segmentedControl = MainSegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleButton(title: " Favoritos")
        let image = UIImage(systemName: "star.fill")
        segmentedControl.button.setImage(image, for: .normal)
        segmentedControl.button.tintColor = .systemGray4
        segmentedControl.isActive(false)
        segmentedControl.button.addTarget(self, action: #selector(favoriteButtonAction(_:)), for: .touchUpInside)
        return segmentedControl
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Pesquisar"
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "Arial", size: 18)
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemBlue
        textField.rightViewMode = .always
        textField.rightView = imageView
        textField.delegate = self
        return textField
    }()
    
    lazy var medicinesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MedicinesTableViewCell.self, forCellReuseIdentifier: MedicinesTableViewCell.medicinesCell)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        setUserCurrent()
        setComponents()
        setConstraint()
        configComponents()
    }
    
    private func setUserCurrent() {
        FirebaseManager.shared.getUserDocument() { user in
            self.userNameLabel.text = user["name"] as? String
            let photo = "\(user["photo"] ?? "")"
            self.perfilImageView.image = photo.extractImageFromBase64
        }
    }
    
    private func configComponents() {
        view.backgroundColor = .white
        perfilImageView.layer.cornerRadius = perfilImageView.frame.height / 2
    }
    
    private func setComponents() {
        view.addSubview(containerView)
        containerView.addSubview(perfilImageView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(historyButton)
        containerView.addSubview(favoriteButton)
        view.addSubview(searchTextField)
        view.addSubview(medicinesTableView)
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
            
            userNameLabel.topAnchor.constraint(equalTo: perfilImageView.centerYAnchor, constant: -10),
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
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            medicinesTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            medicinesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            medicinesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            medicinesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func historyButtonAction(_: MainSegmentedControl) {
        historyButton.isActive(true)
        favoriteButton.isActive(false)
        favoriteButton.button.tintColor = .systemGray4
    }
    
    @objc private func favoriteButtonAction(_: MainSegmentedControl) {
        favoriteButton.isActive(true)
        favoriteButton.button.tintColor = .systemYellow
        historyButton.isActive(false)
    }
    
    private func apiRequest() {
        guard let search = searchTextField.text, search != "" else {return}
        ApiManager.shared.fetchData(medicine: search) { response, error in
            if response?.content.count ?? 0 > 0 {
                self.medicines = response
                self.medicinesTableView.reloadData()
            } else {
                var message: String
                if let error = error {
                    message = error
                } else {
                    message = "Medicamento não encontrado."
                }
                let alert = UIAlertController(title: "Falha", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                alert.view.backgroundColor = .white
                self.present(alert, animated: true)
            }
        }
    }
}

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines?.content.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicinesTableViewCell.medicinesCell) as! MedicinesTableViewCell
        cell.setCell(medicine: medicines?.content[indexPath.row].name ?? "", laboratory: medicines?.content[indexPath.row].laboratory ?? "")
        return cell
    }
    
}

extension MainPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        apiRequest()
        return true
    }
}
