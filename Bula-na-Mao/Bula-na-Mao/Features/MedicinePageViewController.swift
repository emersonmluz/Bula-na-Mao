//
//  MedicinePageViewController.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 08/05/23.
//

import UIKit
import WebKit

class MedicinePageViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var url: URL?
    var urlBase: String = "https://bula.vercel.app/pdf?id="
    var endpoint: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Voltar"
    }
    
    private func setupUI() {
        setComponents()
        setConstraint()
        configComponents()
    }
    
    private func setComponents() {
        view.addSubview(webView)
    }
    
    private func configComponents() {
        webView.navigationDelegate = self
        url = URL(string: urlBase + endpoint)
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
