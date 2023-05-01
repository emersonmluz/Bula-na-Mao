//
//  CustomButton.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 01/05/23.
//

import UIKit

class MainButton: UIButton {
    
    var titleButton: TitleButton = .login {
        didSet {
            setButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setButton() {
        if titleButton == .login {
            setTitle("Login", for: .normal)
        } else {
            setTitle("Registrar", for: .normal)
        }
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        layer.borderWidth = 0.7
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    enum TitleButton {
        case login, register
    }
}
