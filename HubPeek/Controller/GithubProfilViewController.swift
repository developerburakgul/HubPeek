//
//  GithubProfilViewController.swift
//  HubPeek
//
//  Created by Burak Gül on 31.03.2024.
//

import UIKit
import WebKit

class GithubProfilViewController: UIViewController{
    @IBOutlet var webView: WKWebView!
    var urlString : String?
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func loadView() {
        super.loadView()
        if let str = urlString, let url = URL(string: str) {
            webView.load(URLRequest(url: url))
        }
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GithubProfilViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
