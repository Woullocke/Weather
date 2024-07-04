import Foundation
import CoreLocation

struct WeatherURL {
    private let apiKey = "6c3801b1036035758241772066716dc8"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    func url(forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        return components?.url
    }
}

struct SunriseSunsetURL {
    private static let baseURL = "https://api.sunrisesunset.io/json"

    static func url(forLatitude latitude: Double, longitude: Double) -> URL? {
        let urlString = "\(baseURL)?lat=\(latitude)&lng=\(longitude)"
        return URL(string: urlString)
    }
}

struct PictureURL {
    static let sunCity = "https://golnk.ru/dZgrQ"
    static func getSunCity() -> URL? {
        return URL(string: sunCity)
    }
}
