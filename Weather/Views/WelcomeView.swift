import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var isSelectCityViewPresented: Bool = false

    var body: some View {
        VStack {
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
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
        .environmentObject(LocationManager())
}
