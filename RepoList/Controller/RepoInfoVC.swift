//
//  RepoInfoVC.swift
//  RepoList
//
//  Created by Moo Maa on 20/05/2021.
//

import UIKit
import WebKit

class RepoInfoVC: UIViewController {
    //MARK: - Properties
    var repoURL: String?
    
    //MARK: - Private properties
    private var webView = WKWebView()

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    //MARK: - Private methods
    private func setupWebView() {
        webView.navigationDelegate = self
        view = webView
        guard let urlString = repoURL else { return }
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

//MARK: - WebKit delegate
extension RepoInfoVC: WKNavigationDelegate {}
