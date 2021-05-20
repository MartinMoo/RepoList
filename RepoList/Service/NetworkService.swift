//
//  NetworkService.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import Foundation

protocol NetworkServiceDelegate: class {
    func didUpdateData(data: [Repository]?)
    func didFailWithError(error: Error)
}

class NetworkService {
    let gitHubURL = "https://api.github.com"
    
    weak var delegate: NetworkServiceDelegate?
    
    func fetchGitHubRepos(for organization: String) {
        let urlString = "\(gitHubURL)/orgs/\(organization)/repos?q=&per_page=100"
        print(urlString)
        performRequest(with: urlString)
    }
    

    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if response == response {
                    print("Server response: \(String(describing: response))")
                }
                if let data = data {
                    if let decodedData = self.parseJSON(data) {
                        self.delegate?.didUpdateData(data: decodedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ data: Data) -> [Repository]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode([Repository].self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
