//
//  WarningView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/17/24.
//

import SwiftUI


struct WarningView: View {
    @Environment(\.selectedTheme) var theme: Theme
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    WarningHeaderView(title1: "Apnea", title2: "Manager")
                }
                .ignoresSafeArea()
                    
                VStack {
                    Text("WARNING")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                        .padding(.bottom)
                    
                    Text("This app is intended for static dry freedive apnea training and is not a substitute for professional freediving instruction. By using this app, you acknowledge that freediving can involve physical demands and risks, and you must have received proper training and certification from a certified instructor in static dry freedive apnea. You are solely responsible for your safety during training sessions, ensuring a safe environment, and having a trained supervisor present. You must follow all safety protocols and guidelines, including proper breath-hold techniques and equalization. Using this app is at your own risk, and the developers are not liable for any injuries or accidents. Your use of the app signifies your understanding and agreement to prioritize safety and responsible training practices at all times.")
                        .padding(.leading)
                        .padding(.trailing)
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        
                }
                
                Spacer()
  
                NavigationLink {
                    MainTab(theme: theme)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("I Agree")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.blue))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .background(.white)
        }
        .splashViewModifier {
          ZStack {
            SplashView()
          }
        }
    }
}

#Preview {
    WarningView()
}
