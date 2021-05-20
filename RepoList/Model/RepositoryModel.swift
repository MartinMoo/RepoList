//
//  GitHubDataModel.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import Foundation

struct Repository: Decodable {
    let fullName: String
    let description: String?
    let updatedAt: String?
    let stargazersCount: Int
    let owner: Owner
    let htmlUrl: String
}

extension Repository {
    init(title: String, text: String, image: String) {
        let owner = Owner(avatarUrl: image)
        self.init(fullName: title, description: text, updatedAt: nil, stargazersCount: 0, owner: owner, htmlUrl: "")
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
