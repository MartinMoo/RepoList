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
        let urlString = "\(gitHubURL)/orgs/\(organization)/repos"
        print(urlString)
        performRequest(with: urlString)
//        if let decodedData = self.parseJSON(testData!) {
//            self.delegate?.didUpdateData(data: decodedData)
//        }
    }

    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
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
    
    private let testData = """
    [
      {
        "full_name": "Taky/Dlhsia Testovacia Nazov/Tutok/Nech Vidim",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherAndMapApp",
        "description": "UIKit + MapKit + Combine + CoreData + Decodable protocol, MVC",
        "updated_at": "2021-05-16T14:32:07Z",
        "stargazers_count": 0,
      },
      {
        "full_name": "2",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherApp",
        "description": "UIKit + MapKit + Core Data + Codable protocol + Delegate protocol, MVC",
        "updated_at": "2021-05-16T14:31:33Z",
        "stargazers_count": 0,
      },      {
        "full_name": "3",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherAndMapApp",
        "description": "UIKit + MapKit + Combine + CoreData + Decodable protocol, MVC",
        "updated_at": "2021-05-16T14:32:07Z",
        "stargazers_count": 0,
      },
      {
        "full_name": "4",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherApp",
        "description": "UIKit + MapKit + Core Data + Codable protocol + Delegate protocol, MVC",
        "updated_at": "2021-05-16T14:32:07Z",
        "stargazers_count": 0,
      },      {
        "full_name": "5",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherAndMapApp",
        "description": "UIKit + MapKit + Combine + CoreData + Decodable protocol, MVC",
        "updated_at": null,
        "stargazers_count": 0,
      },
      {

        "name": "WeatherApp",
        "full_name": "6",
        "owner": {
          "avatar_url": "https://avatars.githubusercontent.com/u/46962873?v=4",
        },
        "html_url": "https://github.com/MartinMoo/WeatherApp",
        "description": "UIKit + MapKit + Core Data + Codable protocol + Delegate protocol, MVC",
        "updated_at": "2021-05-16T14:31:33Z",
        "stargazers_count": 0,
      }
    ]
    """.data(using: .utf8)
}
