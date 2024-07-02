//
//  WeatherView.swift
//  Weather
//
//  Created by Иван Булгаков on 2.7.2024.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack{
                        VStack(spacing: 20){
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.temp.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
             
                }
                .frame(maxWidth: .infinity)
                
                AsyncImage(url: URL(string: ""))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 0.0, green: 0.0, blue: 0.5, opacity: 1.0))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    let sampleWeather = ResponseBody(
        coord: ResponseBody.CoordinatesResponse(lon: 37.6156, lat: 55.7522),
        weather: [ResponseBody.WeatherResponse(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
        main: ResponseBody.MainResponse(temp: 25.0, feels_like: 24.0, temp_min: 20.0, temp_max: 30.0, pressure: 1012, humidity: 50),
        name: "Sample City",
        wind: ResponseBody.WindResponse(speed: 5.0, deg: 180)
    )
    
    return WeatherView(weather: sampleWeather)
}
