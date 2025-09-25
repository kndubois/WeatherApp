import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var loading = false
    @Published var errorMessage: String?

    private let apiKey = "68e248e0ba7c9d65520e7defa21273b6" 

    func fetchWeather(city: String) {
        loading = true
        errorMessage = nil
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { 
            self.errorMessage = "Invalid URL"
            self.loading = false
            return 
            }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                do {
                    self.weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                } catch {
                    self.errorMessage = "Failed to decode weather"
                }
            }
        }.resume()
    }
}
