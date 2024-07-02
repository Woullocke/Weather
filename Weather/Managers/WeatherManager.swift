//
//  WeatherManager.swift
//  Weather
//
//  Created by Иван Булгаков on 2.7.2024.
//
//  Key api (OpenWeather) 6c3801b1036035758241772066716dc8
// api.openweathermap.org/data/2.5/weather?lat=(lat}&lon={lon}&appid={API key}

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather(latitide: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody{
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitide)&lon=\(longitude)&appid=\("6c3801b1036035758241772066716dc8")&units=metric") else {fatalError("Missing URL. Error!")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather data for API")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse 
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
  
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    struct WindResponse: Decodable {
        var speed: Double 
        var deg: Double
    }
}
