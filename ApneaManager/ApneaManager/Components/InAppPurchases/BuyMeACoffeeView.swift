//
//  BuyMeACoffeeView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/10/24.
//

import SwiftUI
import SceneKit
import StoreKit

struct BuyMeACoffeeView: View {
    /// For 3D model
    @State var scene: SCNScene? = .init(named: "Coffee_Shop_Cup.scn")
    
    /// Fore revenueCat
    @State var myProduct: Product?
    @State var showPaywall = false
    
    /// For Tips views
    @State private var showTips = false
    @State private var showThanks = false
    
    @EnvironmentObject private var store: TipStore
    
    var body: some View {
        NavigationStack {
            ZStack {
 

                VStack(spacing: 20) {


                    // Coffee cup image
                    SceneView(scene: $scene)
                        .frame(height: 350)
                    
                    Text("Buy me a coffee")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    VStack(alignment: .leading) {
                        // Description text
                        Label("Fueling Ongoing Progress", systemImage: "lightbulb.fill")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.primary) // Replace with your custom color
                            .padding(2)
                        
                        // Description text
                        Label("Empowering Future Endeavors", systemImage: "arrow.right.circle.fill")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.primary) // Replace with your custom color
                            .padding(2)
                        
                        // Description text
                        Label("Supporting My Caffeine Fix", systemImage: "mug.fill")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.primary) // Replace with your custom color
                            .padding(2)
                    }




                    // Purchase button
                    Button(action: {
                        showTips.toggle()
                    }) {
                        Text("Support")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 50)
                            .background(Color(Color.blue)) // Replace with your custom color
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    Group {
                        if showTips {
                            Color.black.opacity(0.8)
                                .ignoresSafeArea()
                                .transition(.opacity)
                                .onTapGesture {
                                    showTips.toggle()
                                }
                            TipsView {
                                showTips.toggle()
                            }
                            .environmentObject(store)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                )
                .overlay(alignment: .bottom, content: {
                    
                    if showThanks {
                        ThanksView {
                            showThanks = false
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                })
                .animation(.spring(), value: showTips)
                .animation(.spring(), value: showThanks)
                .onChange(of: store.action) { action in
                    
                    if action == .successful {
                        
                        showTips = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            showThanks = true
                            store.reset()
                        }
                    }
                }
                .alert(isPresented: $store.hasError, error: store.error) {
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BuyMeACoffeeView()
            .environmentObject(TipStore())
    }
}
