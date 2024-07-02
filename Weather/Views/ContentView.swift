import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    @State private var weather: ResponseBody?
    @State private var showingAlert = false
    @State private var errorMessage: String?

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
                                locationManager.error = error // Устанавливаем ошибку для отображения алерта
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
        .onReceive(locationManager.$error) { error in
            if let error = error {
                errorMessage = error.localizedDescription
                showingAlert = true
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK")) {
                    locationManager.error = nil
                    showingAlert = false
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
