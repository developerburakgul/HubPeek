//
//  GithubProfileViewController.swift
//  HubPeek
//
//  Created by Burak Gül on 31.03.2024.
//

import UIKit
import WebKit

class GithubProfileViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView = {
        
        let webConfiguration = WKWebViewConfiguration()
        var webView  = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }()
    var urlString : String?
    var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    override func loadView() {
        super.loadView()
        
        webView.uiDelegate = self
                webView.navigationDelegate = self // Bu satır önemli

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configuration()
        if let str = urlString, let url = URL(string: str) {
            webView.load(URLRequest(url: url))
        }
        
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    private func configuration()  {
        configurationWebView()
        configurationActivityIndicator()
    }
    
    private func configurationWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func configurationActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            activityIndicator.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
}


extension GithubProfileViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
