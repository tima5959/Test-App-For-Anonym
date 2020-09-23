//
//  MainViewController.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 21.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Dependencies
    let networkService = NetworkService()
    
    // MARK: - Outlets
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Public properties

    // MARK: - Constants
    var model = [News]()
    
    // MARK: - Private properties
    private let cellID = "MainViewControllerCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure (методы настраивающие UI элементы)
    private func configureView() {
        navigationController?.delegate = self
        view.backgroundColor = .white
        getRequest()
    }
    
    private func configureTableView() {
        setTableViewLayout()
        tableView.register(MainViewControllerCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
            self.model = news
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Actions
}


extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MainViewControllerCell
        
        
        
        
        return cell
    }
    
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    
}


extension MainViewController: UINavigationControllerDelegate {
    
}
