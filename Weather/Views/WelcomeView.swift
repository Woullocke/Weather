//
//  WelcomeView.swift
//  Weather
//
//  Created by Иван Булгаков on 2.7.2024.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                Text("Welcome to the Weather")
                    .bold().font(.title)
                    .foregroundColor(.white)

                
                Text("Please share your current location to get the weather in your area")
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                LocationButton(.shareCurrentLocation){
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
