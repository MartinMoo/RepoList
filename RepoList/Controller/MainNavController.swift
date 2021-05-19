//
//  MainNavController.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import UIKit

class MainNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
    }
    
    private func setupNavController() {
        let reposTableVC = ReposTableVC()
        self.viewControllers = [reposTableVC]
    }
}
