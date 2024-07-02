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
                    
                    // ЗАМЕНИТЬ КАРТИНКУ НА БОЛЕЕ ОРГАНИЧНУЮ
                    AsyncImage(url: URL(string: "https://gas-kvas.com/grafic/uploads/posts/2024-01/gas-kvas-com-p-nadpisi-gorodov-na-prozrachnom-fone-39.png")){
                        image in image
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
            
            VStack{
                Spacer()
                
                VStack(){
                    Text("Information")
                        .bold().font(.system(size: 20))
                        .foregroundColor(ColorsManager.textDarkColor)
                    
                    
                    HStack{
                        Image(systemName: "thermometer.sun.fill")
                            .foregroundColor(ColorsManager.textDarkColor)
                        Text(weather.main.temp_max.roundDouble() + "°")
                            .foregroundColor(ColorsManager.textDarkColor)

                    
                    }
                    VStack(alignment: .leading, spacing: 20){
                        Text("Max Temp")
                            .foregroundColor(ColorsManager.textDarkColor)
                    }
                    
                    HStack{
                        Image(systemName: "thermometer.snowflake")
                            .foregroundColor(ColorsManager.textDarkColor)
                        Text(weather.main.temp_min.roundDouble() + "°")
                            .foregroundColor(ColorsManager.textDarkColor)
                    }
                    VStack(alignment: .leading, spacing: 20){
                        Text("Min Temp")
                            .foregroundColor(ColorsManager.textDarkColor)
                    }
                    
                    HStack{
                        Image(systemName: "wind")
                            .foregroundColor(ColorsManager.textDarkColor)
                        Text(weather.wind.speed.roundDouble() + " km/h")
                            .foregroundColor(ColorsManager.textDarkColor)
                    }
                    VStack(alignment: .leading, spacing: 20){
                        Text("Speed Wind")
                            .foregroundColor(ColorsManager.textDarkColor)
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
