//
//  WeatherViewController.swift
//  weatherApp
//
//  Created by Андрей Антонов on 05.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()
    
    private var weatherModel = [Weather]()
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupConstraint()
    }
    
    // MARK: Setup
    
    private func setupTableView() {
        tableView.register(
            DailyTableViewCell.self,
            forCellReuseIdentifier: String(describing: DailyTableViewCell.self)
        )
        tableView.register(
            HourlyCollectionViewCell.self,
            forCellReuseIdentifier: String(describing: HourlyCollectionViewCell.self)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
    }
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

// MARK: Delegete and DataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyTableViewCell.self)) as! DailyTableViewCell
        
        return cell
    }
}
