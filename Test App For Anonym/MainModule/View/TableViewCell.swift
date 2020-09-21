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
    
    let bannerImage = UIImageView() // вроде просто картинка
    let genderLabel = UILabel()
    let nameLabel = UILabel()
    let photo = UIImageView() // вроде аватарка
    
    let likesLabel = UILabel()
    let contentPhoto = UIImageView()
    let contentValue = UILabel()
    
    let statsComments = UILabel()
    let statsLikes = UILabel()
    let statsShares = UILabel()
    let statsViews = UILabel()
    let createdTime = UILabel()
    
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
        contentView.addSubview(bannerImage)
        contentView.addSubview(genderLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(photo)
        contentView.addSubview(likesLabel)
        contentView.addSubview(contentPhoto)
        contentView.addSubview(contentValue)
        contentView.addSubview(statsLikes)
        contentView.addSubview(statsViews)
        contentView.addSubview(statsShares)
        contentView.addSubview(statsComments)
        contentView.addSubview(createdTime)
        
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentPhoto.translatesAutoresizingMaskIntoConstraints = false
        contentValue.translatesAutoresizingMaskIntoConstraints = false
        statsLikes.translatesAutoresizingMaskIntoConstraints = false
        statsViews.translatesAutoresizingMaskIntoConstraints = false
        statsShares.translatesAutoresizingMaskIntoConstraints = false
        statsComments.translatesAutoresizingMaskIntoConstraints = false
        createdTime.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
             
        ])
    }
    
}
