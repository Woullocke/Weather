import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var settingsManager = SettingsManager()
        var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(settingsManager)
        }
    }
}
