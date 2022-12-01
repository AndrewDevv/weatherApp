//
//  WeatherViewController.swift
//  weatherApp
//
//  Created by Андрей Антонов on 05.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.alpha = 0.7
        tableView.layer.cornerRadius = 20
        
        return tableView
    }()
    private let weatherImageView = UIImageView()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 50)
        return label
    }()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var dailyModel = [DailyData]()
    private var hourlyModel = [HourlyData]()
    private let networkManeger: NetworkProtocol = NetworkManeger()
    private let serviceParsing: Parseble = ParsingService()
    
    
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLocation()
    }
    
    // MARK: Setup
    
    private func setupView() {
        view.backgroundColor = .white
        view.backgroundImageView(image: "BackgroundSunset")
        
        view.addSubview(weatherImageView)
        view.addSubview(tempLabel)
        view.addSubview(tableView)
        
        tableView.register(
            DailyTableViewCell.self,
            forCellReuseIdentifier: String(describing: DailyTableViewCell.self)
        )
        tableView.register(
            HourlyTableViewCell.self,
            forCellReuseIdentifier: String(describing: HourlyTableViewCell.self)
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100),
            weatherImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100)
            ])
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tempLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func getHourlyWeatherForecast(url: NSURL) {
        networkManeger.reqeastData(url: url) { [weak self] data in
            guard let self = self else { return }
            
            self.serviceParsing.parseHourly(jsonData: data, complition: { model in
                let hourlyWeather = model.data
                self.hourlyModel = hourlyWeather
                DispatchQueue.main.async {
                    self.weatherImageView.image = UIImage(named: hourlyWeather.first?.weather.icon ?? "200")
                    self.tempLabel.text = "\(Int(hourlyWeather.first?.temp ?? 999))º"
                }
            })
        }
    }
    
    private func getDailyWeatherForecast(url: NSURL) {
        networkManeger.reqeastData(url: url) { [weak self] data in
            guard let self = self else { return }
            
            self.serviceParsing.parseDaily(jsonData: data, complition: { model in
                let daylyWeather = model.data
                self.dailyModel.append(contentsOf: daylyWeather)
            })
        }
    }
    
    // MARK: Setup location
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func reqestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        let dailyUrl = NSURL(string: "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=\(lat)&lon=\(long)&units=metric&lang=ru")!
        let hourlyUrl = NSURL(string: "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/hourly?lat=\(lat)&lon=\(long)&hours=24")!
        
        
        getHourlyWeatherForecast(url: hourlyUrl)
        getDailyWeatherForecast(url: dailyUrl)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dailyModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: HourlyTableViewCell.self),
                for: indexPath
                ) as! HourlyTableViewCell
            cell.configure(model: hourlyModel)
            return cell
        }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DailyTableViewCell.self),
            for: indexPath
            ) as! DailyTableViewCell
        cell.configure(model: dailyModel[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 50
    }
}

// MARK: CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            reqestWeatherForLocation()
        }
    }
}

extension UIView {
    func backgroundImageView(image: String) -> UIImageView {
        let imageView: UIImageView = {
            let imageView = UIImageView(frame: self.bounds)
            imageView.image = UIImage(named: image)
            return imageView
        }()
        self.addSubview(imageView)
        return imageView
    }
}
