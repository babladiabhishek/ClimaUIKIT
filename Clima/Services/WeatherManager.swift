//
//  WeatherManager.swift
//  Clima
//


import Foundation
import CoreLocation



struct WeatherManager {
    func fetchWeather(cityName: String) async {
        guard let urlString = Constants.Urls.baseUrl else { return  }
        do {
          let fetchedWeather = try await  performRequest(url: urlString)
        } catch {
            print(NetworkError.badUrl)
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        guard let urlString = Constants.Urls.baseUrl else { return  }
        do {
        let fetchedWeather = try  await  performRequest(url: urlString)
        } catch {
            print(NetworkError.badUrl)
        }
    }
    
    
    func performRequest(url: URL) async throws -> WeatherInfo? {
        if #available(iOS 15.0, *) {
            let (data,_) =  try await URLSession.shared.data(from: url)
            let weather = try? JSONDecoder().decode(WeatherInfo.self, from: data)
            return weather
        } else {
            // Fallback on earlier versions
            print("earlier version")
            return nil
        }
       }
    }
    



enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
}
