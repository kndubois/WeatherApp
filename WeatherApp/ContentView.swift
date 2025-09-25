//
//  ContentView.swift
//  WeatherApp
//
//  Created by Katie Dubois on 9/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showDashboard = false

    var body: some View {
        if viewModel.loading {
            VStack {
                ProgressView("Loading weather...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemIndigo).ignoresSafeArea())
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 20) {
                Text("Oops!")
                    .font(.title)
                    .foregroundColor(.white)

                Text(error)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)

                Button("Retry") {
                    viewModel.fetchWeather(city: "Jupiter,FL,US")
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemIndigo).ignoresSafeArea())
        } else if showDashboard, let weather = viewModel.weather {
            WeatherDashboardView(weather: weather)
        } else {
            WelcomeView {
                viewModel.fetchWeather(city: "Jupiter,FL,US")
                showDashboard = true
            }
        }
    }
}

#Preview {
    ContentView()
}
