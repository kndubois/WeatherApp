import SwiftUI

struct WeatherDashboardView: View {
    let weather: WeatherResponse

    var body: some View {
        ZStack {
            Color(red: 0/255, green: 26/255, blue: 70/255).ignoresSafeArea() // background color

            VStack(spacing: 16) {
                VStack(spacing: 4) { // location
                    Text(weather.name)
                        .font(.title)
                        .foregroundColor(.white)

                    Text(Date().formatted(date: .abbreviated, time: .shortened)) // date
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                Text("\(Int(weather.main.temp))°")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)


                if let condition = weather.weather.first {
                    Text(condition.description.capitalized)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))

                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(condition.icon)@2x.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }    

                Spacer()

                HStack {
                    WeatherInfoItem(title: "Min temp", value: "\(Int(weather.main.temp_min))°")
                    WeatherInfoItem(title: "Max temp", value: "\(Int(weather.main.temp_max))°")
                    WeatherInfoItem(title: "Wind", value: "\(weather.wind.speed) m/s")
                    WeatherInfoItem(title: "Humidity", value: "\(weather.main.humidity)%")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct WeatherInfoItem: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}
