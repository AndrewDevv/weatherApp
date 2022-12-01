//
//  HourlyWeatherModel.swift
//  weatherApp
//
//  Created by Андрей Антонов on 18.11.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation

// MARK: - HourlyWeatherModel
struct HourlyWeatherModel: Codable {
    let cityName, countryCode: String
    let data: [HourlyData]
    let lat, lon: Double
    let stateCode, timezone: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case data, lat, lon
        case stateCode = "state_code"
        case timezone
    }
}

// MARK: - Datum
struct HourlyData: Codable {
    let appTemp: Double
    let clouds, cloudsHi, cloudsLow, cloudsMid: Int
    let datetime: String
    let dewpt, dhi, dni, ghi: Double
    let ozone: Double
    let pod: String
    let pop, precip: Int
    let pres: Double
    let rh: Int
    let slp: Double
    let snow, snowDepth: Int
    let solarRAD, temp: Double
    let timestampLocal, timestampUTC: String
    let ts: Int
    let uv, vis: Double
    let weather: Weather
    let windCdir: String
    let windCdirFull: String
    let windDir: Int
    let windGustSpd, windSpd: Double
    
    enum CodingKeys: String, CodingKey {
        case appTemp = "app_temp"
        case clouds
        case cloudsHi = "clouds_hi"
        case cloudsLow = "clouds_low"
        case cloudsMid = "clouds_mid"
        case datetime, dewpt, dhi, dni, ghi, ozone, pod, pop, precip, pres, rh, slp, snow
        case snowDepth = "snow_depth"
        case solarRAD = "solar_rad"
        case temp
        case timestampLocal = "timestamp_local"
        case timestampUTC = "timestamp_utc"
        case ts, uv, vis, weather
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
        case windDir = "wind_dir"
        case windGustSpd = "wind_gust_spd"
        case windSpd = "wind_spd"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let icon, weatherDescription: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case icon
        case weatherDescription = "description"
        case code
    }
}
