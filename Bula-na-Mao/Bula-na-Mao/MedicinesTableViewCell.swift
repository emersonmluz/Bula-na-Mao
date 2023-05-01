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
    lazy var laboratoryLabel = setLabel(text: "", textColor: .systemGray4, fontSize: 16)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
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
            medicineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            medicineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            medicineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            laboratoryLabel.topAnchor.constraint(equalTo: medicineLabel.topAnchor, constant: 5),
            laboratoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            laboratoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            laboratoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func setCell(medicine: String, laboratory: String) {
        medicineLabel.text = medicine
        laboratoryLabel.text = laboratory
    }
    
    private func setLabel(text: String, textColor: UIColor, fontSize: Float) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: CGFloat(fontSize))
        label.text = text
        label.textColor = textColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }

}
