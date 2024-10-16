//
//  ContentView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 21/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    var body: some View {
        ZStack {
            BackgroundColor(isNight: isNight)
           
    
            VStack{
                
                Text("Hello, world!")
                    .font(.system(size: 32,weight: .medium))
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 10) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180,height: 180)
                    
                    Text("76°")
                        .font(.system(size: 32,weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 40)
                
                Spacer()
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 20)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 20)
                    WeatherDayView(dayOfWeek: "WEN", imageName: "cloud.sun.fill", temperature: 20)
                    WeatherDayView(dayOfWeek: "THUR", imageName: "cloud.sun.fill", temperature: 20)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 20)
                }
                
                Spacer()
                
                
                Button(action: {
                    isNight.toggle()
                }, label: {
                    Text("Change Days Time")
                        .frame(width: 280,height: 50)
                        .background(Color.white)
                        .font(.system(size: 20,weight: .bold,design: .default))
                })
                
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature:  Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 16,weight: .medium,design: .default))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28,weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}


struct BackgroundColor: View {
    var isNight: Bool

    var body: some View {

        if #available(iOS 16.0, *) {
            ContainerRelativeShape()
                .fill(isNight ? Color.black.gradient : Color.blue.gradient)
                .ignoresSafeArea()
        } else {
            LinearGradient(gradient: Gradient(colors: [isNight ?.black : .red, isNight ?.gray : .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
        }
        
    }
}
