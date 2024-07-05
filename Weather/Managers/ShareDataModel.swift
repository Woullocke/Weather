import SwiftUI
import Combine

class SharedDataModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var weather: ResponseBody?
    @Published var sunriseSunset: SunriseSunsetResponse?
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchCoordinates(for city: String) {
        isLoading = true
        let apiKey = "ffd4afc2614b4fde9b6c55fbc1f7dd02"
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(GeoapifyResponse.self, from: data)
                        if let firstFeature = decodedResponse.features.first {
                            self.latitude = firstFeature.properties.lat
                            self.longitude = firstFeature.properties.lon
                        } else {
                            self.latitude = nil
                            self.longitude = nil
                        }
                    } catch {
                        print("Error decoding response: \(error)")
                        self.latitude = nil
                        self.longitude = nil
                    }
                } else {
                    self.latitude = nil
                    self.longitude = nil
                }
            }
        }.resume()
    }

    func fetchWeatherAndSunriseSunset() {
        guard let latitude = latitude, let longitude = longitude else { return }
        isLoading = true
        Task {
            do {
                let weatherManager = WeatherManager()
                let sunriseSunsetManager = SunriseSunsetManager()
                self.weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                self.sunriseSunset = try await sunriseSunsetManager.getSunriseSunsetAsync(latitude: latitude, longitude: longitude)
                self.isLoading = false
            } catch {
                print("Error getting weather or sunrise/sunset: \(error)")
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
