import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var sunriseSunset: SunriseSunsetResponse
    @EnvironmentObject var settingsManager: SettingsManager

    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(weather.name)
                                .bold().font(.title)
                            Spacer()

                        }
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                switch weather.weather[0].main {
                                case "Clear":
                                    Image(systemName: "sun.max")
                                        .font(.system(size: 40))
                                case "Clouds":
                                    Image(systemName: "cloud")
                                        .font(.system(size: 40))
                                case "Atmosphere":
                                    Image(systemName: "tropicalstorm")
                                        .font(.system(size: 40))
                                case "Snow":
                                    Image(systemName: "cloud.snow")
                                        .font(.system(size: 40))
                                case "Rain":
                                    Image(systemName: "cloud.heavyrain")
                                        .font(.system(size: 40))
                                case "Drizzle":
                                    Image(systemName: "cloud.drizzle")
                                        .font(.system(size: 40))
                                case "Thunderstorm":
                                    Image(systemName: "cloud.bolt.rain")
                                        .font(.system(size: 40))
                                default:
                                    Image(systemName: "square.and.arrow.up.trianglebadge.exclamationmark.fill")
                                        .font(.system(size: 40))
                                }

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

                        // ЗАМЕНИТЬ КАРТИНКУ НА БОЛЕЕ ОРГАНИЧНУЮ
                        AsyncImage(url: PictureURL.getSunCity()) { image in image
                                .image?.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        }

                        Spacer()

                    }
                    .frame(maxWidth: .infinity)

                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Spacer()

                    VStack {
                        Text("Information")
                            .bold().font(.system(size: 20))
                            .foregroundColor(ColorsManager.textDarkColor)

                        HStack {
                            if settingsManager.toggles[0] == true {
                                Image(systemName: "thermometer.sun.fill")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(weather.main.tempMax.roundDouble() + "°")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Spacer()
                            } else {
                                Image(systemName: "thermometer.sun.fill")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Text(weather.main.tempMax.roundDouble() + "°")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Spacer()
                            }
                            if settingsManager.toggles[4] == true {
                                Image(systemName: "aqi.medium")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(weather.main.pressure.roundDouble() + " hpa")
                                    .foregroundColor(ColorsManager.textDarkColor)
                            } else {
                                Image(systemName: "aqi.medium")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Text(weather.main.pressure.roundDouble() + " hpa")
                                    .foregroundColor(ColorsManager.textLightColor)
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                if settingsManager.toggles[0] == true {
                                    Text("Max Temp")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                    Spacer()
                                } else {
                                    Text("Max Temp")
                                        .foregroundColor(ColorsManager.textLightColor)
                                    Spacer()
                                }
                                if settingsManager.toggles[4] == true {
                                    Text("Pressure")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                } else {
                                    Text("Pressure")
                                        .foregroundColor(ColorsManager.textLightColor)
                                }
                            }
                        }

                        HStack {
                            if settingsManager.toggles[1] == true {
                                Image(systemName: "thermometer.snowflake")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(weather.main.tempMin.roundDouble() + "°")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Spacer()
                            } else {
                                    Image(systemName: "thermometer.snowflake")
                                        .foregroundColor(ColorsManager.textLightColor)
                                    Text(weather.main.tempMin.roundDouble() + "°")
                                        .foregroundColor(ColorsManager.textLightColor)
                                    Spacer()
                            }
                            if settingsManager.toggles[3] == true {
                                Image(systemName: "humidity")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(weather.main.humidity.roundDouble() + " %")
                                    .foregroundColor(ColorsManager.textDarkColor)
                            } else {
                                Image(systemName: "humidity")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Text(weather.main.humidity.roundDouble() + " %")
                                    .foregroundColor(ColorsManager.textLightColor)
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                if settingsManager.toggles[1] == true {
                                    Text("Min Temp")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                    Spacer()
                                } else {
                                    Text("Min Temp")
                                        .foregroundColor(ColorsManager.textLightColor)
                                    Spacer()
                                }
                                if settingsManager.toggles[3] == true {
                                    Text("Humidity")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                } else {
                                    Text("Humidity")
                                        .foregroundColor(ColorsManager.textLightColor)
                                }
                            }
                        }

                        HStack {
                            if settingsManager.toggles[2] == true {
                                Image(systemName: "wind")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(weather.wind.speed.roundDouble() + " m/s")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Spacer()
                            } else {
                                Image(systemName: "wind")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Text(weather.wind.speed.roundDouble() + " m/s")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Spacer()
                            }
                            if settingsManager.toggles[5] == true {
                                Image(systemName: "sunset")
                                    .foregroundColor(ColorsManager.textDarkColor)
                                Text(sunriseSunset.results.sunset)
                                    .foregroundColor(ColorsManager.textDarkColor)
                            } else {
                                Image(systemName: "sunset")
                                    .foregroundColor(ColorsManager.textLightColor)
                                Text(sunriseSunset.results.sunset)
                                    .foregroundColor(ColorsManager.textLightColor)
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                if settingsManager.toggles[2] == true {
                                    Text("Speed Wind")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                    Spacer()
                                } else {
                                        Text("Speed Wind")
                                            .foregroundColor(ColorsManager.textLightColor)
                                        Spacer()
                                }
                                if settingsManager.toggles[5] == true {
                                    Text("Sunset")
                                        .foregroundColor(ColorsManager.textDarkColor)
                                } else {
                                    Text("Sunset")
                                        .foregroundColor(ColorsManager.textLightColor)
                                }
                            }
                        }

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(ColorsManager.textDarkColor)
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])

                }

            }
            .edgesIgnoringSafeArea(.bottom)
            .background(ColorsManager.backgroundColor)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    let sampleWeather = ResponseBody(
        coord: ResponseBody.CoordinatesResponse(lon: 37.6156, lat: 55.7522),
        weather: [
            ResponseBody.WeatherResponse(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        ],
        main: ResponseBody.MainResponse(
            temp: 25.0,
            feelsLike: 24.0,
            tempMin: 20.0,
            tempMax: 30.0,
            pressure: 1012,
            humidity: 50
        ),
        name: "Sample City",
        wind: ResponseBody.WindResponse(speed: 5.0, deg: 180)
    )

    let sampleSunriseSunset = SunriseSunsetResponse(
        results: Results(
            sunrise: "4:45 AM",
            sunset: "7:55 PM",
            solarNoon: "12:20 PM"
        ),
        status: "OK"
    )

    WeatherView(weather: sampleWeather, sunriseSunset: sampleSunriseSunset)
}
