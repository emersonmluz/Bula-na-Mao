//
//  MedicinesTableViewCell.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 01/05/23.
//

import UIKit

class MedicinesTableViewCell: UITableViewCell {
    static let medicinesCell = "medicinesCell"
    private lazy var medicineLabel = setLabel(text: "", textColor: .black, fontSize: 18)
    private lazy var laboratoryLabel = setLabel(text: "", textColor: .systemGray3, fontSize: 16)
    
    private var favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite == false {
                favoriteImage.image = UIImage(systemName: "star")
                favoriteImage.tintColor = .systemGray3
                
            } else {
                favoriteImage.image = UIImage(systemName: "star.fill")
                favoriteImage.tintColor = .systemYellow
            }
        }
    }
    
    var gestureHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI() {
        setComponents()
        setConstraints()
    }
    
    private func setComponents() {
        contentView.addSubview(medicineLabel)
        contentView.addSubview(laboratoryLabel)
        contentView.addSubview(favoriteImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            medicineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            medicineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            medicineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            laboratoryLabel.topAnchor.constraint(equalTo: medicineLabel.bottomAnchor, constant: 5),
            laboratoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            laboratoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            laboratoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            favoriteImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            favoriteImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteImage.heightAnchor.constraint(equalToConstant: 30),
            favoriteImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setCell(medicine: String, laboratory: String) {
        setupUI()
        medicineLabel.text = medicine
        laboratoryLabel.text = laboratory
        setTapInImage()
    }
    
    private func setTapInImage() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(tapFavoriteImage(_:)))
        favoriteImage.addGestureRecognizer(touch)
    }
    
    private func setLabel(text: String, textColor: UIColor, fontSize: Float) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: CGFloat(fontSize))
        label.text = text
        label.textColor = textColor
        label.numberOfLines = 0
        return label
    }
    
    @objc private func tapFavoriteImage(_ sender: UITapGestureRecognizer) {
        isFavorite = !(isFavorite)
        gestureHandler?()
    }
}
