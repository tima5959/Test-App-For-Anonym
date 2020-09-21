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
    let tableView = UITableView()
    
    // MARK: - Public properties

    // MARK: - Constants
    let model = [News]()
    
    // MARK: - Private properties

    // MARK: - Lifecycle
    override func loadView() {
        
    }
    
    override func viewDidLoad() {
        
    }
    
    // MARK: - Configure (методы настраивающие UI элементы)
    
    
    // MARK: - Public methods

    // MARK: - Private methods
    private func getRequest() {
        networkService.fetchNews({ (news) in
            print("OK")
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
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
