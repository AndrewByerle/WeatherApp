//
//  ContentView.swift
//  Swift-Weather
//
//  Created by Andrew Byerle on 12/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack{
                CityText(cityTextName: "Cupertino, CA")
                MainWeather(image: isNight ? "cloud.moon.fill" : "cloud.sun.fill", temperature: "76")
                HStack(spacing: 20){
                    WeatherDay(dayOfWeek: "TUE", imgName: "cloud.sun.fill", temperature: 49)
                    WeatherDay(dayOfWeek: "WED", imgName: "sun.max.fill", temperature: 50)
                    WeatherDay(dayOfWeek: "THUR", imgName: "cloud.snow.fill", temperature: 28)
                    WeatherDay(dayOfWeek: "FRI", imgName: "cloud.rain.fill", temperature: 44)
                    WeatherDay(dayOfWeek: "SAT", imgName: "cloud.sun.fill", temperature: 55)
                }
                Spacer()
                Button{
                    print("hello")
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", backgroundColor: .white, textColor: .blue)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDay: View {
    var dayOfWeek: String
    var imgName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imgName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityText: View {
    var cityTextName: String
    
    var body: some View {
        Text(cityTextName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeather: View {
    var image: String
    var temperature: String
    
    var body: some View {
        VStack(spacing: 8){
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
        }.padding(.bottom, 40)
    }
}

