//
//  WeatherData.swift
//  Clima
//
//  Created by Abhishek babladi on 2022-03-24.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherInfo: Codable {
    let coord: Coordinate
    let name: String
    let main: Main
    let weather: [Weather]
}
