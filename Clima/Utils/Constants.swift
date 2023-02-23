//
//  Constants.swift
//  Clima
//
//  Created by Abhishek babladi on 2022-03-24.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static let baseUrl: URL? = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=8ff5b09bab55f8f7987c4508b287962f")
        
        
        static func getWeatherUrl(cityName : String) -> URL {
            return URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=8ff5b09bab55f8f7987c4508b287962f")!
        }
        
       
        
    }
    
}
