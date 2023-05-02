//
//  CustomButton.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 28/04/23.
//

import UIKit

class MainSegmentedControl: UIView {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: CGFloat(20))
        button.backgroundColor = .clear
        return button
    }()
    
    private let bottonBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        setComponents()
        setContraints()
    }
    
    private func setComponents() {
        self.addSubview(button)
        self.addSubview(bottonBarView)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            bottonBarView.topAnchor.constraint(equalTo: button.bottomAnchor),
            bottonBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottonBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottonBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setTitleButton(title: String) {
        button.setTitle(title, for: .normal)
    }
    
    func isActive(_ active: Bool) {
        if  active == true {
            button.setTitleColor(.white, for: .normal)
            bottonBarView.isHidden = false
        } else {
            button.setTitleColor(.systemGray4, for: .normal)
            bottonBarView.isHidden = true
        }
    }
}
