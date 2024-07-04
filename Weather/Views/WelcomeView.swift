import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager

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

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
