//
//  ContentView.swift
//  Swift-Weather
//
//  Created by Andrew Byerle on 12/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    @State var results = TaskEntry()
    @State var dailyTemperatures = [Double]()

    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack{
                CityText(cityTextName: "Manhattan, NY")
                MainWeather(image: isNight ? "cloud.moon.fill" : "cloud.sun.fill", temperature: "\(dailyTemperatures.count > 0 ? dailyTemperatures[0] : 0)")
                HStack(spacing: 20){
                    WeatherDay(dayOfWeek: "TUE", imgName: "cloud.sun.fill", temperature: dailyTemperatures.count > 0 ? Int(dailyTemperatures[1]) : 0)
                    WeatherDay(dayOfWeek: "WED", imgName: "sun.max.fill", temperature: dailyTemperatures.count > 0 ? Int(dailyTemperatures[2]) : 0)
                    WeatherDay(dayOfWeek: "THUR", imgName: "cloud.snow.fill", temperature: dailyTemperatures.count > 0 ? Int(dailyTemperatures[3]) : 0)
                    WeatherDay(dayOfWeek: "FRI", imgName: "cloud.rain.fill", temperature: dailyTemperatures.count > 0 ? Int(dailyTemperatures[4]) : 0)
                    WeatherDay(dayOfWeek: "SAT", imgName: "cloud.sun.fill", temperature: dailyTemperatures.count > 0 ? Int(dailyTemperatures[5]) : 0)
                }
                Spacer()
                Button{
                    print("hello")
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", backgroundColor: .white, textColor: .blue)
                }

                Spacer()
            }.onAppear(perform: loadData)
        }
    }

    func loadData() {
        print("SHEEE \(results)")
            guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=35.91&longitude=-79.06&daily=temperature_2m_max&temperature_unit=fahrenheit&timezone=America%2FNew_York") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(TaskEntry.self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                            self.dailyTemperatures = response.daily?.temperature_2m_max ?? []
                            print(dailyTemperatures)
                        }
                        return
                    }
                }
            }.resume()
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

