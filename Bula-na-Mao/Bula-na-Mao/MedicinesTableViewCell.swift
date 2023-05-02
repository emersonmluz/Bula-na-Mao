//
//  MedicinesTableViewCell.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 01/05/23.
//

import UIKit

class MedicinesTableViewCell: UITableViewCell {
    static let medicinesCell = "medicinesCell"
    lazy var medicineLabel = setLabel(text: "", textColor: .black, fontSize: 18)
    lazy var laboratoryLabel = setLabel(text: "", textColor: .systemGray3, fontSize: 16)
    
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
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            medicineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            medicineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            medicineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            laboratoryLabel.topAnchor.constraint(equalTo: medicineLabel.bottomAnchor, constant: 5),
            laboratoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            laboratoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            laboratoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func setCell(medicine: String, laboratory: String) {
        setupUI()
        medicineLabel.text = medicine
        laboratoryLabel.text = laboratory
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

}
