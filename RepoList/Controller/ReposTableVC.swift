//
//  ReposTableVC.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import UIKit
import SDWebImage

class ReposTableVC: UITableViewController {
    //MARK: - Private properties
    private let networkService = NetworkService()
    private var fetchingData = false
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
        networkService.fetchGitHubRepos(for: "apple")
    }
    
    //MARK: - Private methods
    private func setupTable() {
        tableView.register(ReposTableCellView.self, forCellReuseIdentifier: "RepoCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? ReposTableCellView else { return UITableViewCell() }
        cell.repositoryInfo = repositories[indexPath.row]
        let imageURL = repositories[indexPath.row].owner.avatarUrl
        if fetchingData {
        cell.avatarImage.sd_setImage(with: URL(string: imageURL),
                                    placeholderImage: UIImage(),
                                    options: SDWebImageOptions.highPriority,
                                    context: nil,
                                    progress: nil )
        } else {
            cell.avatarImage.image = UIImage(systemName: imageURL)
        }
        return cell
    }
    
    // MARK: - Table view row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callRepoInfo(for: repositories[indexPath.row].htmlUrl)
    }
}

//MARK: - NetworkService delegate
extension ReposTableVC: NetworkServiceDelegate {
    func didUpdateData(data: [Repository]?) {
        fetchingData = true
        reposData = data
    }
    
    func didFailWithError(error: Error) {
        reposData = [Repository(title: "Ooops", text: error.localizedDescription, image: "exclamationmark.triangle.fill")]
    }
}
