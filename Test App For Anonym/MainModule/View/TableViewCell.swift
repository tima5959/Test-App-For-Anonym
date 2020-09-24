//
//  TableViewCell.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 22.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

class MainViewControllerCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
        let avatarView = UIImageView()
        avatarView.layer.cornerRadius = 15
        avatarView.layer.masksToBounds = true
        avatarView.contentMode = .scaleToFill
        avatarView.image = UIImage(named: "notFound")
        return avatarView
    }()
    
    let nameLabel = UILabel()
    let createdTime = UILabel()
    
    let contentValue = UILabel()
    let contentPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.isHidden = true
        return image
    }()
    
    let statsComments = UILabel()
    let statsLikes = UILabel()
    let statsShares = UILabel()
    let statsViews = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: News) {
        nameLabel.text = data.author?.name
        createdTime.text = data.createdAt(timeIntervalSince1970: data.updatedAt ?? 0)
        contentValue.text = data.contents?.first?.data?.value
        if data.contents?.first?.data?.small != nil {
            self.contentPhoto.isHidden = false
        }
    }
    
}

extension MainViewControllerCell {
    
    private func configureViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentPhoto)
        contentView.addSubview(contentValue)
        contentView.addSubview(statsLikes)
        contentView.addSubview(statsViews)
        contentView.addSubview(statsShares)
        contentView.addSubview(statsComments)
        contentView.addSubview(createdTime)
        contentView.addSubview(avatarImage)
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentPhoto.translatesAutoresizingMaskIntoConstraints = false
        contentValue.translatesAutoresizingMaskIntoConstraints = false
        statsLikes.translatesAutoresizingMaskIntoConstraints = false
        statsViews.translatesAutoresizingMaskIntoConstraints = false
        statsShares.translatesAutoresizingMaskIntoConstraints = false
        statsComments.translatesAutoresizingMaskIntoConstraints = false
        createdTime.translatesAutoresizingMaskIntoConstraints = false
        
        configureTitleLabels()
    }
    
    private func configureTitleLabels() {
        
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .black
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.text = "nameLabel.text"
        
        createdTime.numberOfLines = 0
        createdTime.adjustsFontSizeToFitWidth = true
        createdTime.textColor = .black
        createdTime.font = .preferredFont(forTextStyle: .headline)
        createdTime.text = "createdTime.text"
        
        contentValue.numberOfLines = 0
        contentValue.adjustsFontSizeToFitWidth = true
        contentValue.textColor = .black
        contentValue.font = .preferredFont(forTextStyle: .body)
        contentValue.text = ""
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),

            createdTime.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            createdTime.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            createdTime.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            contentValue.topAnchor.constraint(equalTo: createdTime.bottomAnchor, constant: 8),
            contentValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentValue.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            contentPhoto.topAnchor.constraint(equalTo: contentValue.bottomAnchor, constant: 8),
            contentPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
        ])
    }
    
}
