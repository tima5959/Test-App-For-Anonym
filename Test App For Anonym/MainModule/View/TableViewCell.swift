//
//  TableViewCell.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 22.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

class MainViewControllerCell: UITableViewCell {
    
    static let reuseID = "MainViewControllerCell"
    
    let avatarImage = UIImageView() // вроде просто картинка
    let nameLabel = UILabel()
    let createdTime = UILabel()
    
    let contentPhoto = UIImageView()
    let contentValue = UILabel()
    
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
    
    func configureTitleLabels() {
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .white
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.text = "nameLabel.text"
        
        createdTime.numberOfLines = 0
        createdTime.adjustsFontSizeToFitWidth = true
        createdTime.textColor = .white
        createdTime.font = .preferredFont(forTextStyle: .headline)
        createdTime.text = "createdTime.text"
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 16),
            
            createdTime.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            createdTime.leftAnchor.constraint(equalTo: avatarImage.leftAnchor, constant: 16),
            createdTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
        ])
    }
    
}
