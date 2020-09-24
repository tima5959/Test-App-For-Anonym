//
//  MainViewController.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 21.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Dependencies
    private let networkService = NetworkService()
    
    // MARK: - Outlets
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Public properties

    // MARK: - Constants
    var model: [News] = []
    
    // MARK: - Private properties
    private let cellID = "MainViewControllerCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure (методы настраивающие UI элементы)
    private func configureView() {
        view.backgroundColor = .white
        getRequest()
        configureTableView()
    }
    
    private func configureTableView() {
        setTableViewLayout()
        tableView.register(MainViewControllerCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
            
        ])
    }
    
    // MARK: - Public methods

    // MARK: - Private methods
    private func getRequest() {
        networkService.fetchNews({ [weak self] news in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.model = news
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Actions
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 400
    }    
}

extension MainViewController: UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MainViewControllerCell
        
        let news = model[indexPath.row]
        let avatarURL = news.author?.banner?.data?.extraSmall?.url
        let contentPhoto = news.contents?.first?.data?.small?.url
        
        cell.configureCell(news)
        
        DispatchQueue.main.async { [weak self] in
            if avatarURL != nil {
                cell.avatarImage.image = self?.networkService.setImage(indexPath, by: avatarURL ?? "")
            } else {
                cell.avatarImage.image = UIImage(named: "notFound")
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            if contentPhoto != nil {
                cell.contentPhoto.image = self?.networkService.setImage(indexPath, by: contentPhoto ?? "")
                cell.contentPhoto.isHidden = false
            } else {
                cell.contentPhoto.isHidden = true
            }
        }
        return cell
    }
    
}
