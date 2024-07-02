import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    @State private var weather: ResponseBody?

    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitide: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(ColorsManager.backgroundColor)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

