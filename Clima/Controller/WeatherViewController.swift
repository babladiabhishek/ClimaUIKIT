//
//  ViewController.swift
//  Clima
//


import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    private var weatherVM = WeatherViewListModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherVM.delegate = self
        searchTextField.delegate = self
        self.measureTimeComplexity()
    }

}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
        if let city =  self.searchTextField.text  {
            Task.detached {
                await self.weatherVM.getWeather(cityName: city)
            }
        }
        searchTextField.text = ""
    }

    func measureTimeComplexity() {
        let startTime = DispatchTime.now()
        for _ in 1...50 {
            Task.detached {
                await self.weatherVM.getWeather(cityName: "Dubai")
                await self.weatherVM.getWeather(cityName: "Mumbai")
                await self.weatherVM.getWeather(cityName: "Uppsala")
            }
        }
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let timeComplexity = Double(nanoTime) / 1_000_000_000
        print("Time complexity: \(timeComplexity) seconds")
    }

}
//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherViewListModel, weather: WeatherInfoViewModel)  {
       Task {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: self.weatherVM.weather.conditionName)
            self.cityLabel.text = self.weatherVM.weather?.cityName
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
    private func didUpdateLocation(locations: [CLLocation]) async {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            await weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
         
         if locations.first != nil {
                    
                 }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
   
}
