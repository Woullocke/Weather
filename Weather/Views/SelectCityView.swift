import SwiftUI
import Foundation

struct GeoapifyResponse: Codable {
    struct Feature: Codable {
        struct Properties: Codable {
            let lon: Double
            let lat: Double
        }
        let properties: Properties
    }
    let features: [Feature]
}

struct SelectCityView: View {
    @State private var cityName: String = ""
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            TextField("Enter city name", text: $cityName, onCommit: {
                fetchCoordinates(for: cityName)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5, anchor: .center)
            } else {
                if let lat = latitude, let lon = longitude {
                    Text("Latitude: \(lat)")
                        .font(.title)
                    Text("Longitude: \(lon)")
                        .font(.title)
                } else {
                    Text("No coordinates available")
                        .font(.title)
                }
            }
        }
        .navigationTitle("Select City")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchCoordinates(for: cityName)
        }
    }

    func fetchCoordinates(for city: String) {
        isLoading = true
        let apiKey = "ffd4afc2614b4fde9b6c55fbc1f7dd02"
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&apiKey=\(apiKey)"
                guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                isLoading = false
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
}
