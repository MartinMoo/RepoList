//
//  ReposTableCellView.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

import Foundation
import UIKit

class ReposTableCellView: UITableViewCell {
    //MARK: - Properties
    // Set content to labels
    var repositoryInfo: Repository? {
        didSet {
            guard let data = repositoryInfo else { return }
            nameLabel.text = data.fullName
            descriptionLabel.text = data.description
            stargazersLabel.text = String(data.stargazersCount)
            if let updatedAt = data.updatedAt {
                let formatedDate = formatDate(for: updatedAt)
                updatedLabel.text = "\(Localize.List.LastUpdated) :\(String(describing: formatedDate))"
            } else {
                updatedLabel.text = ""
            }

        }
    }

    let imageSize: CGFloat = 50
    
    let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star")?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stargazersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updatedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //MARK: - Implementation
    private func setupCellView() {
        
        // Add Layout Guides
        let contentLayoutContainer = UILayoutGuide()
        let headerLayoutContainer = UILayoutGuide()
        let footerLayoutContainer = UILayoutGuide()
        
        contentView.addLayoutGuide(contentLayoutContainer)
        contentView.addLayoutGuide(headerLayoutContainer)
        contentView.addLayoutGuide(footerLayoutContainer)

        // Add subviews
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(avatarImage)
        contentContainer.addSubview(nameLabel)
        contentContainer.addSubview(descriptionLabel)
        contentContainer.addSubview(starIcon)
        contentContainer.addSubview(stargazersLabel)
        contentContainer.addSubview(updatedLabel)
        
        contentView.backgroundColor = .systemBackground
        contentContainer.backgroundColor = .secondarySystemBackground
        contentContainer.layer.cornerRadius = 10
        avatarImage.layer.cornerRadius = imageSize / 2

        // Set constraints
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            contentLayoutContainer.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 15),
            contentLayoutContainer.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15),
            contentLayoutContainer.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -15),
            contentLayoutContainer.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -15),
            
            headerLayoutContainer.topAnchor.constraint(equalTo: contentLayoutContainer.topAnchor),
            headerLayoutContainer.leadingAnchor.constraint(equalTo: contentLayoutContainer.leadingAnchor),
            headerLayoutContainer.trailingAnchor.constraint(equalTo: contentLayoutContainer.trailingAnchor),
            
            avatarImage.heightAnchor.constraint(equalToConstant: imageSize),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            avatarImage.topAnchor.constraint(equalTo: headerLayoutContainer.topAnchor),
            avatarImage.bottomAnchor.constraint(lessThanOrEqualTo: headerLayoutContainer.bottomAnchor, constant: -15),
            avatarImage.leadingAnchor.constraint(equalTo: headerLayoutContainer.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: headerLayoutContainer.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: headerLayoutContainer.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: headerLayoutContainer.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLayoutContainer.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentLayoutContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentLayoutContainer.trailingAnchor),
            
            footerLayoutContainer.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            footerLayoutContainer.leadingAnchor.constraint(equalTo: contentLayoutContainer.leadingAnchor),
            footerLayoutContainer.trailingAnchor.constraint(equalTo: contentLayoutContainer.trailingAnchor),
            footerLayoutContainer.bottomAnchor.constraint(equalTo: contentLayoutContainer.bottomAnchor),
            
            starIcon.centerYAnchor.constraint(equalTo: stargazersLabel.centerYAnchor,constant: -1),
            starIcon.heightAnchor.constraint(equalToConstant: 15),
            starIcon.widthAnchor.constraint(equalTo: starIcon.heightAnchor),
            starIcon.leadingAnchor.constraint(equalTo: footerLayoutContainer.leadingAnchor),
            
            stargazersLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 3),
            stargazersLabel.topAnchor.constraint(equalTo: footerLayoutContainer.topAnchor, constant: 5),
            stargazersLabel.bottomAnchor.constraint(equalTo: footerLayoutContainer.bottomAnchor),
            
            updatedLabel.topAnchor.constraint(equalTo: footerLayoutContainer.topAnchor, constant: 5),
            updatedLabel.bottomAnchor.constraint(equalTo: footerLayoutContainer.bottomAnchor),
            updatedLabel.leadingAnchor.constraint(greaterThanOrEqualTo: stargazersLabel.trailingAnchor, constant: 5),
            updatedLabel.trailingAnchor.constraint(equalTo: footerLayoutContainer.trailingAnchor)
        ])
    }
    
    private func formatDate(for date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        guard let formatedDate = dateFormatter.date(from: date) else { return "" } // Return should not happen
        dateFormatter.dateStyle = .short
        let formatedDateString = dateFormatter.string(from: formatedDate)
        return formatedDateString
    }
    
}
