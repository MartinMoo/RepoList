//
//  RepoInfoVC.swift
//  RepoList
//
//  Created by Moo Maa on 20/05/2021.
//

import UIKit
import WebKit

class RepoInfoVC: UIViewController {
    var repoURL: String?
    private var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        view = webView
        guard let urlString = repoURL else { return }
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension RepoInfoVC: WKNavigationDelegate {
    
}
