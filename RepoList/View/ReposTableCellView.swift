//
//  ReposTableCellView.swift
//  RepoList
//
//  Created by Moo Maa on 19/05/2021.
//

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
            print(data.updatedAt)
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
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
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

        // Add subviews
        addSubview(contentContainer)
        contentContainer.addSubview(headerView)
        headerView.addSubview(avatarImage)
        headerView.addSubview(nameLabel)
        contentContainer.addSubview(descriptionLabel)
        contentContainer.addSubview(footerView)
        footerView.addSubview(stargazersLabel)
        footerView.addSubview(updatedLabel)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentContainer.backgroundColor = .systemBackground
        contentContainer.layer.cornerRadius = 10
        avatarImage.layer.cornerRadius = imageSize / 2


        // Set constraints
        contentContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        contentContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        contentContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        headerView.topAnchor.constraint(equalTo: contentContainer.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        
        avatarImage.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor).isActive = true
        avatarImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        avatarImage.bottomAnchor.constraint(lessThanOrEqualTo: headerView.bottomAnchor, constant: -15).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 25).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: 15).isActive = true
        
        footerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        footerView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor).isActive = true
        
        stargazersLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5).isActive = true
        stargazersLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -15).isActive = true
        stargazersLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 15).isActive = true
        
        updatedLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 5).isActive = true
        updatedLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -15).isActive = true
        updatedLabel.leadingAnchor.constraint(greaterThanOrEqualTo: stargazersLabel.trailingAnchor, constant: 5).isActive = true
        updatedLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -15).isActive = true
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
