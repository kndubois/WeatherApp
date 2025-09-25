import SwiftUI

struct WelcomeView: View {
    var onShareLocation: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0/255, green: 26/255, blue: 70/255).ignoresSafeArea() // rgba(5, 30, 59, 1)


            VStack(spacing: 30) {
                Text("Welcome to the Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)    
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("Please share your current location to get the weather in your area")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Button(action: onShareLocation) { 
                    Text("Share Current Location")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue) // former blue
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 60)
                }
            }
        }
    }
}
