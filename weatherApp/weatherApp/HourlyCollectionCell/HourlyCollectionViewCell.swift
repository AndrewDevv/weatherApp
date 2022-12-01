//
//  HourlyCollectionViewCell.swift
//  weatherApp
//
//  Created by Андрей Антонов on 23.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let weatherImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupContentView()
        setupConstraint()
    }
    
    private func setupContentView() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherImageView)
        
    }
    
    private func setupConstraint() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 10),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: 10),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
    }
    
    func configure(_ model: HourlyData) {
        timeLabel.text = model.datetime
        weatherImageView.image = UIImage(named: model.weather.icon)
        tempLabel.text = "\(Int(model.temp))º"
    }
}
