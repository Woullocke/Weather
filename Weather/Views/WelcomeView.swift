import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var settingsManager: SettingsManager
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var isSelectCityViewPresented: Bool = false
    @State private var isSettingsViewPresented: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                ColorsManager.backgroundColor
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isSettingsViewPresented.toggle()
                        }) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isSettingsViewPresented) {
                            SettingsView()
                                .environmentObject(settingsManager)
                        }
                    }
                    .padding()
                    VStack(spacing: 20) {
                            Text("Welcome to the Weather")
                            .bold().font(.title)
                            .foregroundColor(ColorsManager.textLightColor)

                        Text("Please share your current location to get the weather in your area")
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(ColorsManager.textLightColor)

                        LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                        }
                        .cornerRadius(30)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                    }
                    .padding()

                    Button(action: {
                        isSelectCityViewPresented.toggle()
                    }) {
                        Text("Choose city")
                            .bold().font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .sheet(isPresented: $isSelectCityViewPresented) {
                        SelectCityView(latitude: $latitude, longitude: $longitude)
                            .environmentObject(settingsManager)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(LocationManager())
}
