import SwiftUI

struct SelectCityView: View {
    @Binding var latitude: Double?
    @Binding var longitude: Double?
    @State private var cityName: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var isWeatherViewPresented: Bool = false

    private let weatherManager = WeatherManager()
    private let sunriseSunsetManager = SunriseSunsetManager()

    @State private var weatherData: ResponseBody?
    @State private var sunriseSunsetData: SunriseSunsetResponse?

    var body: some View {
        ZStack {
            Color(red: 0.0, green: 0.0, blue: 0.4, opacity: 1.0)
            VStack { Text("Enter city name")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                    Text("After entering the city name, press return and wait for the download to complete")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                TextField("Press me", text: $cityName, onCommit: {
                    fetchCoordinates(for: cityName)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
                .multilineTextAlignment(.center)
                Spacer()
                Spacer()

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                } else {
                    if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else if let weatherData = weatherData, let sunriseSunsetData = sunriseSunsetData {
                        Button(action: {
                            isWeatherViewPresented = true
                        }) { Text("Show Weather")
                                .bold().font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .fullScreenCover(isPresented: $isWeatherViewPresented) {
                            WeatherView(weather: weatherData, sunriseSunset: sunriseSunsetData)
                                .navigationBarTitle("Weather", displayMode: .inline)
                        }
                        
                        .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("Select City")
        .navigationBarTitleDisplayMode(.inline)
    }

    func fetchCoordinates(for city: String) {
        isLoading = true
        errorMessage = nil
        let apiKey = "ffd4afc2614b4fde9b6c55fbc1f7dd02"
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }
                guard let data = data else {
                    errorMessage = "No data"
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(GeoapifyResponse.self, from: data)
                    if let firstFeature = decodedResponse.features.first {
                        self.latitude = firstFeature.properties.lat
                        self.longitude = firstFeature.properties.lon
                        fetchWeatherAndSunriseSunset(latitude: firstFeature.properties.lat, longitude: firstFeature.properties.lon)
                    } else {
                        self.latitude = nil
                        self.longitude = nil
                        errorMessage = "Coordinates not found"
                    }
                } catch {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                    self.latitude = nil
                    self.longitude = nil
                }
            }
        }.resume()
    }

    func fetchWeatherAndSunriseSunset(latitude: Double, longitude: Double) {
        Task {
            do {
                let weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                let sunriseSunset = try await sunriseSunsetManager.getSunriseSunsetAsync(latitude: latitude, longitude: longitude)
                self.weatherData = weather
                self.sunriseSunsetData = sunriseSunset
            } catch {
                errorMessage = "Error fetching weather data: \(error.localizedDescription)"
            }
        }
    }
}

struct GeoapifyResponse: Codable {
    struct Feature: Codable {
        struct Properties: Codable {
            let lat: Double
            let lon: Double
        }
        let properties: Properties
    }
    let features: [Feature]
}
