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

struct Owner: Decodable {
    let avatarUrl: String
}
