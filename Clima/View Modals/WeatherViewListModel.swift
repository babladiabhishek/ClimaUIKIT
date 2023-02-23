//
//  WeatherModel.swift
//  Clima
//


import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherViewListModel, weather: WeatherInfoViewModel)
    func didFailWithError(error: Error)
}
class WeatherViewListModel {
    var delegate: WeatherManagerDelegate?
    var weather:WeatherInfoViewModel!

    func getWeather(cityName: String) async {
        do{
            guard let url = URL(string: "\(Constants.Urls.getWeatherUrl(cityName: cityName))") else {
                throw NetworkError.badUrl
            }
            let weather = try await WeatherManager().performRequest(url: url)
            self.weather = weather.map(WeatherInfoViewModel.init)
            self.delegate?.didUpdateWeather(self, weather: self.weather)
        } catch {

        }
    }
}





struct WeatherInfoViewModel {

    let weatherInfo:WeatherInfo


    var conditionId: Int{
        weatherInfo.weather.first!.id
    }
    var cityName: String{
        weatherInfo.name
    }
    var temperature: Double{
        weatherInfo.main.temp
    }

    var temperatureString: String {
        return String(format: "%.f", temperature)
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

}
