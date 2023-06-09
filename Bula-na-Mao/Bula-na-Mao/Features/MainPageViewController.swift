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
    var userFavorite: [MedicineModel] = UserDefaults.standard.value(forKey: "favorites") as? [MedicineModel] ?? []
    var userHistory: [MedicineModel] = UserDefaults.standard.value(forKey: "history") as? [MedicineModel] ?? []
    var medicines: MedicineResponse?
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
    
    lazy var loggoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(loggoutAction(_:)), for: .touchUpInside)
        return button
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
        loadUserDefaults()
        setUserCurrent()
        setComponents()
        setConstraint()
        configComponents()
        self.medicinesTableView.reloadData()
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
        object = userHistory
    }
    
    private func loadUserDefaults() {
        guard let data = UserDefaults.standard.object(forKey: "favorites") as? Data else {return}
           if let favorites = try? JSONDecoder().decode([MedicineModel].self, from: data) {
               userFavorite = favorites
          }
        guard let data = UserDefaults.standard.object(forKey: "history") as? Data else {return}
           if let history = try? JSONDecoder().decode([MedicineModel].self, from: data) {
               userHistory = history
          }
    }
    
    private func setComponents() {
        view.addSubview(containerView)
        containerView.addSubview(perfilImageView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(historyButton)
        containerView.addSubview(favoriteButton)
        containerView.addSubview(loggoutButton)
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
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            
            loggoutButton.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            loggoutButton.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            loggoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loggoutButton.heightAnchor.constraint(equalToConstant: 50),
            
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
        object = userHistory
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
        object = userFavorite
        startLoading()
        medicinesTableView.reloadData()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.stopLoading()
        }
    }
    
    @objc private func loggoutAction(_: UIButton) {
        FirebaseManager.shared.getUserDocument() { user in
            FirebaseManager.shared.updateUser(name: user["name"] as! String, email: user["email"] as! String, password: user["password"] as! String, photo: user["photo"] as! String, rememberLogin: false)
            UserDefaults.standard.set("", forKey: "userLogin")
            UserDefaults.standard.set("", forKey: "userPassword")
        }
        FirebaseManager.shared.signOut()
        navigationController?.popToRootViewController(animated: true)
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
    
    private func goToMedicinePage(index: Int) {
        let controller = MedicinePageViewController()
        controller.endpoint = object[index].id
        navigationController?.pushViewController(controller, animated: false)
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
        for favorite in self.userFavorite {
            if self.object[indexPath.row].name == favorite.name, self.object[indexPath.row].laboratory == favorite.laboratory {
                cell.isFavorite = true
            }
        }
        cell.gestureHandler = {
            if cell.isFavorite == false {
                var cont = 0
                for favorite in self.userFavorite {
                    if self.object[indexPath.row].name == favorite.name, self.object[indexPath.row].laboratory == favorite.laboratory {
                        self.userFavorite.remove(at: cont)
                        UserDefaults.standard.set(self.userFavorite, forKey: "favorites")
                        break
                    }
                    cont += 1
                }
            } else {
                self.userFavorite.append(self.object[indexPath.row])
                if let favorites = try? JSONEncoder().encode(self.userFavorite) {
                   UserDefaults.standard.set(favorites, forKey: "favorites")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.userHistory.append(object[indexPath.row])
        if let history = try? JSONEncoder().encode(self.userHistory) {
           UserDefaults.standard.set(history, forKey: "history")
        }
        goToMedicinePage(index: indexPath.row)
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
