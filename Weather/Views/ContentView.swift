//
//  ContentView.swift
//  Weather
//
//  Created by Иван Булгаков on 2.7.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let weather = weather{
                    Text("Weather data fetched")
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
                if locationManager.isLoading{
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(red: 0.0, green: 0.0, blue: 0.5, opacity: 1.0))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
