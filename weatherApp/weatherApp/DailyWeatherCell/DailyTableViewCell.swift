//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by Андрей Антонов on 23.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    private let dateTimeLabel = UILabel()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "day of week"
        return label
    }()
    private let maxLabel = UILabel()
    private let minLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private let weatherImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupContentView()
        setupConstraint()
    }
    
    private func setupContentView() {
        contentView.addSubview(dateTimeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(maxLabel)
        contentView.addSubview(maxTempLabel)
        contentView.addSubview(minLabel)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(weatherImageView)
    }
    
    private func setupConstraint() {
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topSpacing),
            dateTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateTimeLabel.widthAnchor.constraint(equalToConstant: 100),
            dateTimeLabel.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: Constants.topSpacing),
            dateLabel.leadingAnchor.constraint(equalTo: dateTimeLabel.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        NSLayoutConstraint.activate([
            minLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topSpacing),
            minLabel.leadingAnchor.constraint(equalTo: maxLabel.trailingAnchor, constant: 30),
            minLabel.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 5),
            minTempLabel.leadingAnchor.constraint(equalTo: maxTempLabel.trailingAnchor, constant: 35),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        NSLayoutConstraint.activate([
            maxLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topSpacing),
            maxLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 40),
            maxLabel.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: maxLabel.bottomAnchor, constant: 5),
            maxTempLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 50),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    fileprivate enum Constants {
        static let topSpacing: CGFloat = 10
        static let height: CGFloat = 15
    }
    
    
    func configure(model: DailyData, indexPath: IndexPath) {
        if indexPath.row == 0 {
            maxLabel.text = "Макс"
            minLabel.text = "Мин"
        }
        dateTimeLabel.text = model.datetime
        maxTempLabel.text = "\(Int(model.appMaxTemp))º"
        minTempLabel.text = "\(Int(model.appMinTemp))º"
        weatherImageView.image = UIImage(named: model.weather.icon)
    }
}
