//
//  ReposTableVC.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import UIKit

class ReposTableVC: UITableViewController {
    //MARK: - Private properties
    private let networkService = NetworkService()
    private var repositories: [Repository] = []
    private var reposData: [Repository]? {
        didSet {
            if let data = reposData {
                repositories = data
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        networkService.delegate = self
        networkService.fetchGitHubRepos(for: "sygic")
    }
    
    //MARK: - Private methods
    private func setupTable() {
        tableView.register(ReposTableCellView.self, forCellReuseIdentifier: "RepoCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    private func callRepoInfo(for url: String) {
        let repoInfoVC = RepoInfoVC()
        repoInfoVC.repoURL = url
        navigationController?.pushViewController(repoInfoVC, animated: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! ReposTableCellView
        cell.repositoryInfo = repositories[indexPath.row]
        return cell
    }
    
    // MARK: - Table viewrow selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callRepoInfo(for: repositories[indexPath.row].htmlUrl)
    }
}

//MARK: - NetworkService delegate
extension ReposTableVC: NetworkServiceDelegate {
    func didUpdateData(data: [Repository]?) {
        reposData = data
    }
    
    func didFailWithError(error: Error) {
        print("Error: ", error.localizedDescription)
    }
}
