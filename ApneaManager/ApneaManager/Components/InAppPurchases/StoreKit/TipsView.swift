//
//  TipsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/17/24.
//

import SwiftUI

struct TipsView: View {
    @EnvironmentObject private var store: TipStore
        
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack {
                Spacer()
                Button(action: didTapClose) {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(.largeTitle, design: .rounded).bold())
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.gray, .gray.opacity(0.2))
                }
            }
            
            Text("Enjoying the app so far? 👀")
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("Support the development of our amazing app by leaving a tip today. Your contribution helps us enhance your experience and deliver even more exciting features.")
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            ForEach(store.items) { item in
                TipsItemView(item: item)
            }
        }
        .padding(16)
        .background(Color("card-background"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(8)
        .overlay(alignment: .top) {
            Image("freediver-1")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(6)
                .background(Color.black, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .offset(y: -25)
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView {}
            .environmentObject(TipStore())
    }
}
