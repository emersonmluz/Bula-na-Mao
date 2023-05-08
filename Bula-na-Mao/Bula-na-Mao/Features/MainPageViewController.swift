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
    enum Keyword {
        case medicines, favorites, history
    }
    
    var medicines: MedicineResponse?
    var favorites: [MedicineModel] = []
    var history: [MedicineModel] = []
    var keyword: Keyword = .history
    var object: [MedicineModel] = []
    
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
        textField.backgroundColor = .white
        textField.placeholder = "Pesquisar"
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "Arial", size: 18)
        textField.layer.borderWidth = 0.2
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
    
    var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.2
        view.isHidden = true
        return view
    }()
    
    var spinnerLoading: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .white
        activity.style = .large
        return activity
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
        perfilImageView.layer.cornerRadius = perfilImageView.bounds.height / 2
        perfilImageView.clipsToBounds = true
    }
    
    private func setComponents() {
        view.addSubview(containerView)
        containerView.addSubview(perfilImageView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(historyButton)
        containerView.addSubview(favoriteButton)
        view.addSubview(searchTextField)
        view.addSubview(medicinesTableView)
        view.addSubview(loadingView)
        loadingView.addSubview(spinnerLoading)
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
            medicinesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinnerLoading.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            spinnerLoading.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    @objc private func historyButtonAction(_: MainSegmentedControl) {
        searchTextField.text = ""
        historyButton.isActive(true)
        favoriteButton.isActive(false)
        favoriteButton.button.tintColor = .systemGray4
        object = history
        startLoading()
        medicinesTableView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.stopLoading()
        }
    }
    
    @objc private func favoriteButtonAction(_: MainSegmentedControl) {
        searchTextField.text = ""
        favoriteButton.isActive(true)
        favoriteButton.button.tintColor = .systemYellow
        historyButton.isActive(false)
        object = favorites
        startLoading()
        medicinesTableView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.stopLoading()
        }
    }
    
    private func startLoading() {
        loadingView.isHidden = false
        spinnerLoading.startAnimating()
        containerView.isUserInteractionEnabled = false
    }
    
    private func stopLoading() {
        loadingView.isHidden = true
        spinnerLoading.stopAnimating()
        containerView.isUserInteractionEnabled = true
    }
    
    private func apiRequest() {
        guard let search = searchTextField.text, search != "" else {return}
        startLoading()
        ApiManager.shared.fetchData(medicine: search) { response, error in
            if response?.content.count ?? 0 > 0 {
                self.medicines = response
                self.object = self.medicines?.content ?? []
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
            self.stopLoading()
        }
    }
}

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicinesTableViewCell.medicinesCell) as! MedicinesTableViewCell
        cell.setCell(medicine: object[indexPath.row].name, laboratory: object[indexPath.row].laboratory)
        cell.isFavorite = false
        for favorite in self.favorites {
            if self.object[indexPath.row].name == favorite.name, self.object[indexPath.row].laboratory == favorite.laboratory {
                cell.isFavorite = true
            }
        }
        cell.gestureHandler = {
            if cell.isFavorite == false {
                var cont = 0
                for favorite in self.favorites {
                    if self.object[indexPath.row].name == favorite.name, self.object[indexPath.row].laboratory == favorite.laboratory {
                        self.favorites.remove(at: cont)
                        break
                    }
                    cont += 1
                }
            } else {
                self.favorites.append(self.object[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.history.append(object[indexPath.row])
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
