//
//  ParsingService.swift
//  weatherApp
//
//  Created by Андрей Антонов on 11.11.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation

protocol Parseble {
    func parseDaily(jsonData: Data, complition: @escaping (DailyWeatherModel) -> Void)
    func parseHourly(jsonData: Data, complition: @escaping (HourlyWeatherModel) -> Void)
}

final class ParsingService: Parseble {
    
    func parseDaily(jsonData: Data, complition: @escaping (DailyWeatherModel) -> Void) {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(DailyWeatherModel.self, from: jsonData)
            complition(object)
        } catch {
            print("error")
        }
    }
    
    func parseHourly(jsonData: Data, complition: @escaping (HourlyWeatherModel) -> Void) {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(HourlyWeatherModel.self, from: jsonData)
            complition(object)
        } catch {
            print("error")
        }
    }
}
